import 'package:flutter/material.dart';
import '../data/models/theme_config.dart';
import 'dynamic_theme_generator.dart';

class AppTheme {
  final ThemeConfig config;
  const AppTheme(this.config);

  ThemeMode get mode => config.mode;

  ThemeData get light {
    final base = DynamicThemeGenerator.fromPalette(config.palette, dark: false);
    return DynamicThemeGenerator.applyComponentThemes(base);
  }

  ThemeData get dark {
    final base = DynamicThemeGenerator.fromPalette(config.palette, dark: true);
    return DynamicThemeGenerator.applyComponentThemes(base);
  }
}
