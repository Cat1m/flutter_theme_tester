import 'package:flutter/material.dart';
import '../data/models/theme_config.dart';
import 'dynamic_theme_generator.dart';

class AppTheme {
  final ThemeConfig config;
  const AppTheme(this.config);

  ThemeMode get mode => config.mode;

  ThemeData get light =>
      DynamicThemeGenerator.fromPalette(config.palette, dark: false);
  ThemeData get dark =>
      DynamicThemeGenerator.fromPalette(config.palette, dark: true);
}
