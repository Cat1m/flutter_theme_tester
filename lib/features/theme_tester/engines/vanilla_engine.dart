import 'package:flutter/material.dart';

import '../data/models/color_palette.dart';
import '../utils/color_utils.dart';

class VanillaEngine {
  static ThemeData build({required ColorPalette p, required bool dark}) {
    if (!dark) {
      final cs = ColorScheme(
        brightness: Brightness.light,
        primary: p.primary,
        onPrimary: ColorUtils.getOnColor(p.primary),
        secondary: p.secondary,
        onSecondary: ColorUtils.getOnColor(p.secondary),
        surface: p.surface,
        onSurface: ColorUtils.getOnColor(p.surface),
        background: p.background,
        onBackground: ColorUtils.getOnColor(p.background),
        error: p.error!,
        onError: ColorUtils.getOnColor(p.error!),
        outline: p.outline ?? Colors.grey.shade300,
        outlineVariant: (p.outline ?? Colors.grey.shade300).withOpacity(.6),
        surfaceVariant: ColorUtils.adjustLightness(p.surface, .05),
        inverseSurface: Colors.black,
        onInverseSurface: Colors.white,
        inversePrimary: ColorUtils.adjustLightness(p.primary, .2),
        shadow: Colors.black,
        scrim: Colors.black.withOpacity(.5),
      );

      return ThemeData(
        useMaterial3: true,
        colorScheme: cs,
        scaffoldBackgroundColor: p.background,
      );
    }

    final darkSurface = ColorUtils.convertToDarkSurface(p.surface);
    final darkBg = ColorUtils.convertToDarkBackground(p.background);
    final dPrimary = ColorUtils.adjustForDark(p.primary);
    final dSecondary = ColorUtils.adjustForDark(p.secondary);

    final cs = ColorScheme(
      brightness: Brightness.dark,
      primary: dPrimary,
      onPrimary: ColorUtils.getOnColor(dPrimary),
      secondary: dSecondary,
      onSecondary: ColorUtils.getOnColor(dSecondary),
      surface: darkSurface,
      onSurface: ColorUtils.getOnColor(darkSurface),
      background: darkBg,
      onBackground: ColorUtils.getOnColor(darkBg),
      error: p.error!,
      onError: ColorUtils.getOnColor(p.error!),
      outline: (p.outline ?? Colors.grey.shade600),
      outlineVariant: (p.outline ?? Colors.grey.shade600).withOpacity(.6),
      surfaceVariant: ColorUtils.adjustLightness(darkSurface, -.05),
      inverseSurface: Colors.white,
      onInverseSurface: Colors.black,
      inversePrimary: ColorUtils.adjustLightness(p.primary, -.2),
      shadow: Colors.black,
      scrim: Colors.black.withOpacity(.6),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: darkBg,
    );
  }
}
