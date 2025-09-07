import 'package:flutter/material.dart';

class ColorPalette {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
  });

  factory ColorPalette.defaults() => const ColorPalette(
    primary: Color(0xFF5B3A91),
    secondary: Color(0xFF8E5BD5),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF5F0FF),
  );
}
