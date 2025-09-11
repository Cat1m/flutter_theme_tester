import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../data/models/color_palette.dart';
import '../utils/color_utils.dart';

class FlexEngine {
  static ThemeData build({required ColorPalette p, required bool dark}) {
    final tertiary = ColorUtils.generateTertiary(p.primary, p.secondary);

    if (!dark) {
      final schemeColors = FlexSchemeColor(
        primary: p.primary,
        primaryContainer: ColorUtils.generateContainer(p.primary, false),
        secondary: p.secondary,
        secondaryContainer: ColorUtils.generateContainer(p.secondary, false),
        tertiary: tertiary,
        tertiaryContainer: ColorUtils.generateContainer(tertiary, false),
        error: p.error,
      );

      return FlexThemeData.light(
        useMaterial3: true,
        colors: schemeColors,
        surfaceMode: FlexSurfaceMode.custom,
        blendLevel: 0,
        scaffoldBackground: p.background,
        surface: p.surface,
        colorScheme: ColorScheme.light(
          primary: p.primary,
          secondary: p.secondary,
          surface: p.surface,
          background: p.background,
          error: p.error!,
          onPrimary: ColorUtils.getOnColor(p.primary),
          onSecondary: ColorUtils.getOnColor(p.secondary),
          onSurface: ColorUtils.getOnColor(p.surface),
          onBackground: ColorUtils.getOnColor(p.background),
          outline: p.outline ?? Colors.grey.shade300,
          surfaceContainerHighest: ColorUtils.adjustLightness(p.surface, 0.05),
          onSurfaceVariant: ColorUtils.getOnColor(
            ColorUtils.adjustLightness(p.surface, 0.05),
          ),
        ),
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.surface,
      );
    }

    // dark
    final darkSurface = ColorUtils.convertToDarkSurface(p.surface);
    final darkBg = ColorUtils.convertToDarkBackground(p.background);
    final dPrimary = ColorUtils.adjustForDark(p.primary);
    final dSecondary = ColorUtils.adjustForDark(p.secondary);
    final dTertiary = ColorUtils.adjustForDark(tertiary);

    return FlexThemeData.dark(
      useMaterial3: true,
      colors: FlexSchemeColor(
        primary: dPrimary,
        primaryContainer: ColorUtils.generateContainer(dPrimary, true),
        secondary: dSecondary,
        secondaryContainer: ColorUtils.generateContainer(dSecondary, true),
        tertiary: dTertiary,
        tertiaryContainer: ColorUtils.generateContainer(dTertiary, true),
        error: p.error,
      ),
      surfaceMode: FlexSurfaceMode.custom,
      blendLevel: 0,
      scaffoldBackground: darkBg,
      surface: darkSurface,
      colorScheme: ColorScheme.dark(
        primary: dPrimary,
        secondary: dSecondary,
        surface: darkSurface,
        background: darkBg,
        error: p.error!,
        onPrimary: ColorUtils.getOnColor(dPrimary),
        onSecondary: ColorUtils.getOnColor(dSecondary),
        onSurface: ColorUtils.getOnColor(darkSurface),
        onBackground: ColorUtils.getOnColor(darkBg),
        outline: (p.outline ?? Colors.grey.shade600),
        surfaceContainerHighest: ColorUtils.adjustLightness(darkSurface, -0.05),
        onSurfaceVariant: ColorUtils.getOnColor(
          ColorUtils.adjustLightness(darkSurface, -0.05),
        ),
      ),
    );
  }
}
