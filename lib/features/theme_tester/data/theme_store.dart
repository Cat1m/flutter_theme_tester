import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/color_palette.dart';
import 'models/theme_config.dart';

class ThemeStore {
  static const _kMode = 'theme_mode';
  static const _kPrimary = 'color_primary';
  static const _kSecondary = 'color_secondary';
  static const _kSurface = 'color_surface';
  static const _kBackground = 'color_background';

  Future<ThemeConfig> load() async {
    final sp = await SharedPreferences.getInstance();
    final modeIndex = sp.getInt(_kMode) ?? ThemeMode.system.index;
    Color readColor(String key, int fallback) =>
        Color(sp.getInt(key) ?? fallback);

    final palette = ColorPalette(
      primary: readColor(_kPrimary, const Color(0xFF5B3A91).toARGB32()),
      secondary: readColor(_kSecondary, const Color(0xFF8E5BD5).toARGB32()),
      surface: readColor(_kSurface, const Color(0xFFFFFFFF).toARGB32()),
      background: readColor(_kBackground, const Color(0xFFF5F0FF).toARGB32()),
    );

    return ThemeConfig(mode: ThemeMode.values[modeIndex], palette: palette);
  }

  Future<void> save(ThemeConfig config) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_kMode, config.mode.index);
    await sp.setInt(_kPrimary, config.palette.primary.toARGB32());
    await sp.setInt(_kSecondary, config.palette.secondary.toARGB32());
    await sp.setInt(_kSurface, config.palette.surface.toARGB32());
    await sp.setInt(_kBackground, config.palette.background.toARGB32());
  }
}
