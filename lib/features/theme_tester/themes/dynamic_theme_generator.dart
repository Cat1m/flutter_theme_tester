import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import '../data/models/color_palette.dart';

class DynamicThemeGenerator {
  static ThemeData fromPalette(ColorPalette p, {bool dark = false}) {
    final schemeColors = FlexSchemeColor(
      primary: p.primary,
      primaryContainer: _generateContainer(p.primary, dark),
      secondary: p.secondary,
      secondaryContainer: _generateContainer(p.secondary, dark),
      tertiary: _generateTertiary(p.primary, p.secondary),
      tertiaryContainer: _generateContainer(
        _generateTertiary(p.primary, p.secondary),
        dark,
      ),
    );

    if (!dark) {
      return FlexThemeData.light(
        useMaterial3: true,
        colors: schemeColors,
        surfaceMode: FlexSurfaceMode.custom,
        blendLevel: 0, // Tắt auto blending để dùng custom colors
        // Sử dụng colors đã được design sẵn
        scaffoldBackground: p.background,
        surface: p.surface,

        // Custom overrides cho surfaces khác
        colorScheme: ColorScheme.light(
          primary: p.primary,
          secondary: p.secondary,
          surface: p.surface,
          background: p.background,

          // Ensure proper contrast
          onPrimary: _getOnColor(p.primary),
          onSecondary: _getOnColor(p.secondary),
          onSurface: _getOnColor(p.surface),
          onBackground: _getOnColor(p.background),

          // Additional surfaces for consistency
          surfaceVariant: _adjustLightness(p.surface, 0.05),
          onSurfaceVariant: _getOnColor(_adjustLightness(p.surface, 0.05)),
        ),

        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.surface,
      );
    } else {
      // Generate proper dark variants
      final darkPalette = _generateDarkPalette(p);

      return FlexThemeData.dark(
        useMaterial3: true,
        colors: FlexSchemeColor(
          primary: _adjustForDark(p.primary),
          primaryContainer: _generateContainer(_adjustForDark(p.primary), true),
          secondary: _adjustForDark(p.secondary),
          secondaryContainer: _generateContainer(
            _adjustForDark(p.secondary),
            true,
          ),
          tertiary: _adjustForDark(_generateTertiary(p.primary, p.secondary)),
          tertiaryContainer: _generateContainer(
            _adjustForDark(_generateTertiary(p.primary, p.secondary)),
            true,
          ),
        ),

        surfaceMode: FlexSurfaceMode.custom,
        blendLevel: 0,

        scaffoldBackground: darkPalette.background,
        surface: darkPalette.surface,

        colorScheme: ColorScheme.dark(
          primary: _adjustForDark(p.primary),
          secondary: _adjustForDark(p.secondary),
          surface: darkPalette.surface,
          background: darkPalette.background,

          onPrimary: _getOnColor(_adjustForDark(p.primary)),
          onSecondary: _getOnColor(_adjustForDark(p.secondary)),
          onSurface: _getOnColor(darkPalette.surface),
          onBackground: _getOnColor(darkPalette.background),

          surfaceVariant: _adjustLightness(darkPalette.surface, -0.05),
          onSurfaceVariant: _getOnColor(
            _adjustLightness(darkPalette.surface, -0.05),
          ),
        ),
      );
    }
  }

  // Apply comprehensive component customizations
  static ThemeData applyComponentThemes(ThemeData base) {
    final colorScheme = base.colorScheme;
    final isDark = base.brightness == Brightness.dark;

    return base.copyWith(
      // ===== APP BAR =====
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: colorScheme.primary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        actionsIconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
        iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
      ),

      // ===== CARDS =====
      cardTheme: CardThemeData(
        elevation: isDark ? 2 : 1,
        shadowColor: isDark ? Colors.black54 : Colors.black12,
        surfaceTintColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),

      // ===== BUTTONS =====
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: isDark ? 2 : 1,
          shadowColor: isDark ? Colors.black54 : Colors.black26,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          minimumSize: const Size(88, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          minimumSize: const Size(88, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          minimumSize: const Size(88, 48),
          side: BorderSide(color: colorScheme.outline, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          minimumSize: const Size(64, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // ===== FLOATING ACTION BUTTON =====
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: isDark ? 4 : 2,
        highlightElevation: isDark ? 8 : 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        sizeConstraints: const BoxConstraints.tightFor(width: 56, height: 56),
      ),

      // ===== INPUT DECORATION =====
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? colorScheme.surfaceVariant.withOpacity(0.08)
            : colorScheme.surfaceVariant.withOpacity(0.04),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.38),
            width: 1,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.outline.withOpacity(0.38),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        hintStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.6),
          fontSize: 16,
        ),

        labelStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.8),
          fontSize: 16,
        ),
      ),

      // ===== BOTTOM NAVIGATION BAR =====
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        elevation: isDark ? 8 : 3,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ===== NAVIGATION BAR (Material 3) =====
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.primary,
        elevation: isDark ? 3 : 2,
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return IconThemeData(
              color: colorScheme.onSecondaryContainer,
              size: 24,
            );
          }
          return IconThemeData(
            color: colorScheme.onSurface.withOpacity(0.6),
            size: 24,
          );
        }),
      ),

      // ===== DIVIDER =====
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withOpacity(0.2),
        thickness: 1,
        space: 1,
      ),

      // ===== LIST TILE =====
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
      ),

      // ===== CHIP =====
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceVariant,
        selectedColor: colorScheme.secondaryContainer,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // ===== DIALOG =====
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.primary,
        elevation: isDark ? 6 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface.withOpacity(0.8),
          height: 1.4,
        ),
      ),

      // ===== BOTTOM SHEET =====
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.primary,
        elevation: isDark ? 8 : 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // ===== SNACK BAR =====
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark
            ? colorScheme.inverseSurface
            : colorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          color: colorScheme.inverseSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionTextColor: colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        elevation: isDark ? 6 : 3,
      ),

      // ===== SWITCH =====
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.onPrimary;
          }
          return colorScheme.outline;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surfaceVariant;
        }),
      ),

      // ===== PROGRESS INDICATORS =====
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.primary.withOpacity(0.2),
        circularTrackColor: colorScheme.primary.withOpacity(0.2),
      ),
    );
  }

  // ===== Helper Methods =====

  /// Generate appropriate container color based on base color and theme mode
  static Color _generateContainer(Color base, bool dark) {
    final hsl = HSLColor.fromColor(base);
    if (dark) {
      // Dark containers should be darker and more muted
      return hsl
          .withLightness((hsl.lightness * 0.4).clamp(0.0, 1.0))
          .withSaturation((hsl.saturation * 0.8).clamp(0.0, 1.0))
          .toColor();
    } else {
      // Light containers should be very light
      return hsl
          .withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0))
          .withSaturation((hsl.saturation * 0.5).clamp(0.0, 1.0))
          .toColor();
    }
  }

  /// Generate tertiary color by mixing primary and secondary
  static Color _generateTertiary(Color primary, Color secondary) {
    final primaryHsl = HSLColor.fromColor(primary);
    final secondaryHsl = HSLColor.fromColor(secondary);

    // Blend hues and take average saturation/lightness
    double hueBlend = (primaryHsl.hue + secondaryHsl.hue) / 2;

    // Handle hue wrapping for better color mixing
    if ((primaryHsl.hue - secondaryHsl.hue).abs() > 180) {
      hueBlend = (hueBlend + 180) % 360;
    }

    return HSLColor.fromAHSL(
      1.0,
      hueBlend,
      (primaryHsl.saturation + secondaryHsl.saturation) / 2,
      (primaryHsl.lightness + secondaryHsl.lightness) / 2,
    ).toColor();
  }

  /// Generate proper dark palette from light palette
  static ColorPalette _generateDarkPalette(ColorPalette lightPalette) {
    return ColorPalette(
      primary: lightPalette.primary,
      secondary: lightPalette.secondary,
      surface: _convertToDarkSurface(lightPalette.surface),
      background: _convertToDarkBackground(lightPalette.background),
    );
  }

  /// Convert light surface to appropriate dark surface
  static Color _convertToDarkSurface(Color lightSurface) {
    // Keep the hue but make it dark with low saturation
    final hsl = HSLColor.fromColor(lightSurface);
    return hsl
        .withLightness(0.12) // Material 3 dark surface lightness
        .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  /// Convert light background to appropriate dark background
  static Color _convertToDarkBackground(Color lightBackground) {
    final hsl = HSLColor.fromColor(lightBackground);
    return hsl
        .withLightness(0.06) // Material 3 dark background lightness
        .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  /// Adjust primary/secondary colors for dark theme visibility
  static Color _adjustForDark(Color color) {
    final hsl = HSLColor.fromColor(color);

    // Make colors brighter and more saturated for dark backgrounds
    return hsl
        .withLightness((hsl.lightness + 0.2).clamp(0.3, 0.9))
        .withSaturation((hsl.saturation * 1.1).clamp(0.0, 1.0))
        .toColor();
  }

  /// Determine if color needs light or dark text
  static Color _getOnColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  /// Adjust color lightness by a relative amount
  static Color _adjustLightness(Color color, double adjustment) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + adjustment).clamp(0.0, 1.0))
        .toColor();
  }
}
