import 'package:flutter/material.dart';

class ColorUtils {
  static Color adjustLightness(Color color, double adjustment) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + adjustment).clamp(0.0, 1.0))
        .toColor();
  }

  static Color getOnColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  static Color convertToDarkSurface(Color lightSurface) {
    final hsl = HSLColor.fromColor(lightSurface);
    return hsl
        .withLightness(0.12)
        .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  static Color convertToDarkBackground(Color lightBackground) {
    final hsl = HSLColor.fromColor(lightBackground);
    return hsl
        .withLightness(0.06)
        .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  static Color adjustForDark(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + 0.2).clamp(0.3, 0.9))
        .withSaturation((hsl.saturation * 1.1).clamp(0.0, 1.0))
        .toColor();
  }

  static Color generateContainer(Color base, bool dark) {
    final hsl = HSLColor.fromColor(base);
    if (dark) {
      return hsl
          .withLightness((hsl.lightness * 0.4).clamp(0.0, 1.0))
          .withSaturation((hsl.saturation * 0.8).clamp(0.0, 1.0))
          .toColor();
    } else {
      return hsl
          .withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0))
          .withSaturation((hsl.saturation * 0.5).clamp(0.0, 1.0))
          .toColor();
    }
  }

  static Color generateTertiary(Color primary, Color secondary) {
    final p = HSLColor.fromColor(primary);
    final s = HSLColor.fromColor(secondary);
    double hueBlend = (p.hue + s.hue) / 2;
    if ((p.hue - s.hue).abs() > 180) {
      hueBlend = (hueBlend + 180) % 360;
    }
    return HSLColor.fromAHSL(
      1.0,
      hueBlend,
      (p.saturation + s.saturation) / 2,
      (p.lightness + s.lightness) / 2,
    ).toColor();
  }
}
