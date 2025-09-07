import 'package:flutter/material.dart';
import '../data/models/color_palette.dart';
import '../../../core/enums/predefined_themes.dart';

class PredefinedPalettes {
  static ColorPalette of(PredefinedThemes t) {
    switch (t) {
      case PredefinedThemes.ocean:
        return const ColorPalette(
          primary: Color(0xFF0077B6),
          secondary: Color(0xFF00B4D8),
          surface: Color(0xFFF8FCFF),
          background: Color(0xFFE3F2FD),
        );
      case PredefinedThemes.sunset:
        return const ColorPalette(
          primary: Color(0xFFFF7043),
          secondary: Color(0xFFFFB74D),
          surface: Color(0xFFFFF8F5),
          background: Color(0xFFFFE0B2),
        );
      case PredefinedThemes.forest:
        return const ColorPalette(
          primary: Color(0xFF2E7D32),
          secondary: Color(0xFF66BB6A),
          surface: Color(0xFFF1F8E9),
          background: Color(0xFFC8E6C9),
        );
      case PredefinedThemes.lavender:
        return const ColorPalette(
          primary: Color(0xFF7E57C2),
          secondary: Color(0xFFB39DDB),
          surface: Color(0xFFF3E5F5),
          background: Color(0xFFE1BEE7),
        );
      case PredefinedThemes.ruby:
        return const ColorPalette(
          primary: Color(0xFFC62828),
          secondary: Color(0xFFEF5350),
          surface: Color(0xFFFFEBEE),
          background: Color(0xFFFFCDD2),
        );
      case PredefinedThemes.amber:
        return const ColorPalette(
          primary: Color(0xFFFF8F00),
          secondary: Color(0xFFFFC107),
          surface: Color(0xFF2C2C2C), // Dark surface cho contrast
          background: Color(0xFF1A1A1A), // Dark theme
        );
      case PredefinedThemes.midnight:
        return const ColorPalette(
          primary: Color(0xFF64B5F6),
          secondary: Color(0xFF90CAF9),
          surface: Color(0xFF1E1E1E), // Charcoal surface
          background: Color(0xFF0D1117), // GitHub dark bg
        );

      case PredefinedThemes.sky:
        return const ColorPalette(
          primary: Color(0xFF0288D1),
          secondary: Color(0xFF4FC3F7),
          surface: Color(0xFFE3F2FD),
          background: Color(0xFFBBDEFB),
        );
      case PredefinedThemes.lime:
        return const ColorPalette(
          primary: Color(0xFF9E9D24),
          secondary: Color(0xFFC0CA33),
          surface: Color(0xFFF9FBE7),
          background: Color(0xFFE6EE9C),
        );
      case PredefinedThemes.plum:
        return const ColorPalette(
          primary: Color(0xFF6A1B9A),
          secondary: Color(0xFFAB47BC),
          surface: Color(0xFFF8EAF6),
          background: Color(0xFFE1BEE7),
        );
      case PredefinedThemes.slate:
        return const ColorPalette(
          primary: Color(0xFF455A64),
          secondary: Color(0xFF90A4AE),
          surface: Color(0xFFF5F5F5), // Light gray
          background: Color(0xFFE0E0E0), // Medium gray
        );
      case PredefinedThemes.coral:
        return const ColorPalette(
          primary: Color(0xFFFF6F61),
          secondary: Color(0xFFFF8A65),
          surface: Color(0xFFFFF1EE),
          background: Color(0xFFFFCCBC),
        );
      case PredefinedThemes.gengar94:
        return const ColorPalette(
          // Gengar deep purple
          primary: Color(0xFF5B3A91),
          // Mystic violet
          secondary: Color(0xFF9C4DCC),
          // Soft lavender surface
          surface: Color(0xFFF5F0FF),
          // Light purple background
          background: Color(0xFFEDE7F6),
        );
    }
  }

  static const labels = {
    PredefinedThemes.ocean: 'Ocean',
    PredefinedThemes.sunset: 'Sunset',
    PredefinedThemes.forest: 'Forest',
    PredefinedThemes.lavender: 'Lavender',
    PredefinedThemes.ruby: 'Ruby',
    PredefinedThemes.amber: 'Amber',
    PredefinedThemes.midnight: 'Midnight',
    PredefinedThemes.sky: 'Sky',
    PredefinedThemes.lime: 'Lime',
    PredefinedThemes.plum: 'Plum',
    PredefinedThemes.slate: 'Slate',
    PredefinedThemes.coral: 'Coral',
    PredefinedThemes.gengar94: 'Gengar',
  };
}
