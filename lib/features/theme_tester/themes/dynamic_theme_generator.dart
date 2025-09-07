import 'package:flutter/material.dart';
import '../data/models/color_palette.dart';

class DynamicThemeGenerator {
  static ThemeData fromPalette(ColorPalette palette, {bool dark = false}) {
    final base = ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: dark ? Brightness.dark : Brightness.light,
    );
    return ThemeData(colorScheme: base, useMaterial3: true);
  }
}
