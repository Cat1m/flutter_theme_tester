import 'package:flutter/material.dart';
import '../data/models/theme_config.dart';
import '../data/models/color_palette.dart';
import 'dynamic_theme_generator.dart';

class AppTheme {
  final ThemeMode mode;
  final ThemeData light;
  final ThemeData dark;

  AppTheme._(this.mode, this.light, this.dark);

  factory AppTheme(ThemeConfig config) {
    final p = config.palette;
    final ui = config.ui;

    final lightBase = DynamicThemeGenerator.fromPalette(
      p,
      config: ui,
      dark: false,
    );
    final darkBase = DynamicThemeGenerator.fromPalette(
      p,
      config: ui,
      dark: true,
    );

    // Optional: áp overrides component (nếu bạn muốn giữ như bản trước)
    final lightFull = DynamicThemeGenerator.applyComponentThemes(lightBase);
    final darkFull = DynamicThemeGenerator.applyComponentThemes(darkBase);

    return AppTheme._(config.mode, lightFull, darkFull);
  }
}
