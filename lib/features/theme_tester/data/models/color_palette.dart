import 'package:flutter/material.dart';

class ColorPalette {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;

  /// Optional fields (nếu không truyền sẽ được auto-gen)
  final Color? error;
  final Color? outline;
  final Color? neutral;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    this.error,
    this.outline,
    this.neutral,
  });

  // My favorite pokemon: GENGAR color
  factory ColorPalette.defaults() => const ColorPalette(
    primary: Color(0xFF5B3A91),
    secondary: Color(0xFF8E5BD5),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF5F0FF),
    error: Colors.red, // mặc định, có thể override
    // outline & neutral sẽ auto-gen nếu null
  );

  /// Trả về một bản đầy đủ, gen các màu còn thiếu từ 4 màu chính
  ColorPalette withFallbacks() {
    return ColorPalette(
      primary: primary,
      secondary: secondary,
      surface: surface,
      background: background,
      error: error ?? Colors.red,
      outline: outline ?? _generateOutline(primary, surface),
      neutral: neutral ?? _generateNeutral(surface, background),
    );
  }

  static Color _generateOutline(Color base, Color surface) {
    // Trộn base và surface để ra 1 màu xám nhạt dùng cho border
    return Color.alphaBlend(base.withValues(alpha: .12), surface);
  }

  static Color _generateNeutral(Color surface, Color background) {
    final h1 = HSLColor.fromColor(surface);
    final h2 = HSLColor.fromColor(background);
    return HSLColor.fromAHSL(
      1.0,
      (h1.hue + h2.hue) / 2,
      (h1.saturation + h2.saturation) / 2,
      (h1.lightness + h2.lightness) / 2,
    ).toColor();
  }

  ColorPalette copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Color? error,
    Color? outline,
    Color? neutral,
  }) {
    return ColorPalette(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      error: error ?? this.error,
      outline: outline ?? this.outline,
      neutral: neutral ?? this.neutral,
    );
  }
}
