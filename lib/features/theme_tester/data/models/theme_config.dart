import 'package:flutter/material.dart';
import 'color_palette.dart';

class ThemeConfig {
  final ThemeMode mode;
  final ColorPalette palette;

  const ThemeConfig({required this.mode, required this.palette});

  ThemeConfig copyWith({ThemeMode? mode, ColorPalette? palette}) =>
      ThemeConfig(mode: mode ?? this.mode, palette: palette ?? this.palette);
}
