import 'package:flutter/material.dart';
import 'color_palette.dart';
import 'app_theme_config.dart';

@immutable
class ThemeConfig {
  final ThemeMode mode;
  final ColorPalette palette;
  final AppThemeConfig ui;

  const ThemeConfig({
    required this.mode,
    required this.palette,
    this.ui = AppThemeConfig.defaults,
  });

  ThemeConfig copyWith({
    ThemeMode? mode,
    ColorPalette? palette,
    AppThemeConfig? ui,
  }) {
    return ThemeConfig(
      mode: mode ?? this.mode,
      palette: palette ?? this.palette,
      ui: ui ?? this.ui,
    );
  }

  /// Optional: helper cho light/dark nhanh (không bắt buộc)
  ThemeConfig withMode(ThemeMode m) => copyWith(mode: m);
}
