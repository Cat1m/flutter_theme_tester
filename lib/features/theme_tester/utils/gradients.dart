import 'package:flutter/material.dart';
import '../data/models/color_palette.dart';
import 'color_utils.dart';

class Gradients {
  static Gradient background(ColorPalette p, bool dark) {
    final c1 = dark
        ? ColorUtils.adjustLightness(p.background, -0.12)
        : ColorUtils.adjustLightness(p.background, 0.08);
    final c2 = dark
        ? ColorUtils.adjustLightness(p.primary, -0.20)
        : ColorUtils.adjustLightness(p.primary, 0.12);

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [c1, c2],
    );
  }

  static Gradient duo(Color a, Color b, bool dark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: dark
          ? [
              ColorUtils.adjustLightness(a, -0.04),
              ColorUtils.adjustLightness(b, -0.04),
            ]
          : [
              ColorUtils.adjustLightness(a, 0.04),
              ColorUtils.adjustLightness(b, 0.04),
            ],
    );
  }
}
