import 'package:flutter/material.dart';
import '../data/models/theme_config.dart';
// Xoá import không dùng:
// import '../data/models/color_palette.dart';
import 'dynamic_theme_generator.dart';

class AppTheme {
  final ThemeMode mode;
  final ThemeData light;
  final ThemeData dark;

  AppTheme._(this.mode, this.light, this.dark);

  factory AppTheme(ThemeConfig config) {
    final p = config.palette;
    final ui = config.ui;

    final lightTheme = DynamicThemeGenerator.fromPalette(
      p,
      config: ui,
      dark: false,
    );
    final darkTheme = DynamicThemeGenerator.fromPalette(
      p,
      config: ui,
      dark: true,
    );

    return AppTheme._(config.mode, lightTheme, darkTheme);
  }
}
