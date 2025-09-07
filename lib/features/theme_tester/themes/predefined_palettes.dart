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
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFF2FBFF),
        );
      case PredefinedThemes.sunset:
        return const ColorPalette(
          primary: Color(0xFFFF7043),
          secondary: Color(0xFFFFB74D),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFFFF3E0),
        );
      case PredefinedThemes.forest:
        return const ColorPalette(
          primary: Color(0xFF2E7D32),
          secondary: Color(0xFF66BB6A),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFF1F8E9),
        );
      case PredefinedThemes.lavender:
        return const ColorPalette(
          primary: Color(0xFF7E57C2),
          secondary: Color(0xFFB39DDB),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFF3E5F5),
        );
      case PredefinedThemes.ruby:
        return const ColorPalette(
          primary: Color(0xFFC62828),
          secondary: Color(0xFFEF5350),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFFFEBEE),
        );
      case PredefinedThemes.amber:
        return const ColorPalette(
          primary: Color(0xFFFF8F00),
          secondary: Color(0xFFFFC107),
          surface: Color(0xFF1B1B1B),
          background: Color(0xFFFFF8E1),
        );
      case PredefinedThemes.midnight:
        return const ColorPalette(
          primary: Color(0xFF263238),
          secondary: Color(0xFF546E7A),
          surface: Color(0xFF121212),
          background: Color(0xFF0A0A0A),
        );

      case PredefinedThemes.sky:
        return const ColorPalette(
          primary: Color(0xFF0288D1),
          secondary: Color(0xFF4FC3F7),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFE1F5FE),
        );
      case PredefinedThemes.lime:
        return const ColorPalette(
          primary: Color(0xFF9E9D24),
          secondary: Color(0xFFC0CA33),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFF9FBE7),
        );
      case PredefinedThemes.plum:
        return const ColorPalette(
          primary: Color(0xFF6A1B9A),
          secondary: Color(0xFFAB47BC),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFF8EAF6),
        );
      case PredefinedThemes.slate:
        return const ColorPalette(
          primary: Color(0xFF455A64),
          secondary: Color(0xFF90A4AE),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFECEFF1),
        );
      case PredefinedThemes.coral:
        return const ColorPalette(
          primary: Color(0xFFFF6F61),
          secondary: Color(0xFFFF8A65),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFFFF1EE),
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
  };
}
