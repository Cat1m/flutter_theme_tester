import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

import '../data/models/color_palette.dart';
import '../data/models/app_theme_config.dart';
import '../data/models/theme_enums.dart';

class DynamicThemeGenerator {
  static ThemeData fromPalette(
    ColorPalette palette, {
    required AppThemeConfig config,
    bool dark = false,
  }) {
    final p = palette.withFallbacks();

    // Tạo tokens gradient theo config (chưa dùng ở widget ở bước 1)
    final tokens = AppDecorationTokens(
      backgroundGradient: config.gradientBackground
          ? _backgroundGradient(p, dark)
          : null,
      buttonGradient: config.gradientButton
          ? _gradientFrom(p.primary, p.secondary, dark)
          : null,
      cardGradient: config.gradientCard
          ? _gradientFrom(p.surface, p.background, dark)
          : null,
    );

    // Chọn engine build ThemeData
    switch (config.engine) {
      case ThemeEngine.flex:
        final flexTheme = _buildFlexTheme(p, dark);
        return flexTheme.copyWith(
          extensions: _buildExtensions(flexTheme.extensions, tokens),
        );

      case ThemeEngine.vanilla:
        final vanillaTheme = _buildVanillaTheme(p, dark);
        return vanillaTheme.copyWith(
          extensions: _buildExtensions(vanillaTheme.extensions, tokens),
        );
    }
  }

  // ====================== HELPER FOR EXTENSIONS ======================

  static Iterable<ThemeExtension<dynamic>> _buildExtensions(
    Map<Object, ThemeExtension<dynamic>> existingExtensions,
    AppDecorationTokens tokens,
  ) {
    // Tạo danh sách các extensions, bao gồm cả các extension hiện tại và tokens mới
    return [tokens, ...existingExtensions.values];
  }

  // ====================== FLEX ENGINE ======================

  static ThemeData _buildFlexTheme(ColorPalette p, bool dark) {
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
      error: p.error,
    );

    if (!dark) {
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
          onPrimary: _getOnColor(p.primary),
          onSecondary: _getOnColor(p.secondary),
          onSurface: _getOnColor(p.surface),
          onBackground: _getOnColor(p.background),
          outline: p.outline ?? Colors.grey.shade300,
          // M3 container variant-ish
          surfaceContainerHighest: _adjustLightness(p.surface, 0.05),
          onSurfaceVariant: _getOnColor(_adjustLightness(p.surface, 0.05)),
        ),
        appBarElevation: 0,
        appBarStyle: FlexAppBarStyle.surface,
      );
    } else {
      final darkSurface = _convertToDarkSurface(p.surface);
      final darkBg = _convertToDarkBackground(p.background);

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
          error: p.error,
        ),
        surfaceMode: FlexSurfaceMode.custom,
        blendLevel: 0,
        scaffoldBackground: darkBg,
        surface: darkSurface,
        colorScheme: ColorScheme.dark(
          primary: _adjustForDark(p.primary),
          secondary: _adjustForDark(p.secondary),
          surface: darkSurface,
          background: darkBg,
          error: p.error!,
          onPrimary: _getOnColor(_adjustForDark(p.primary)),
          onSecondary: _getOnColor(_adjustForDark(p.secondary)),
          onSurface: _getOnColor(darkSurface),
          onBackground: _getOnColor(darkBg),
          outline: (p.outline ?? Colors.grey.shade600),
          surfaceContainerHighest: _adjustLightness(darkSurface, -0.05),
          onSurfaceVariant: _getOnColor(_adjustLightness(darkSurface, -0.05)),
        ),
      );
    }
  }

  // ====================== VANILLA ENGINE ======================

  static ThemeData _buildVanillaTheme(ColorPalette p, bool dark) {
    if (!dark) {
      final cs = ColorScheme(
        brightness: Brightness.light,
        primary: p.primary,
        onPrimary: _getOnColor(p.primary),
        secondary: p.secondary,
        onSecondary: _getOnColor(p.secondary),
        surface: p.surface,
        onSurface: _getOnColor(p.surface),
        background: p.background,
        onBackground: _getOnColor(p.background),
        error: p.error!,
        onError: _getOnColor(p.error!),
        // M3 fields
        outline: p.outline ?? Colors.grey.shade300,
        outlineVariant: (p.outline ?? Colors.grey.shade300).withOpacity(.6),
        surfaceVariant: _adjustLightness(p.surface, .05),
        inverseSurface: Colors.black,
        onInverseSurface: Colors.white,
        inversePrimary: _adjustLightness(p.primary, .2),
        shadow: Colors.black,
        scrim: Colors.black.withOpacity(.5),
      );

      return ThemeData(
        useMaterial3: true,
        colorScheme: cs,
        scaffoldBackgroundColor: p.background,
      );
    } else {
      final darkSurface = _convertToDarkSurface(p.surface);
      final darkBg = _convertToDarkBackground(p.background);

      final cs = ColorScheme(
        brightness: Brightness.dark,
        primary: _adjustForDark(p.primary),
        onPrimary: _getOnColor(_adjustForDark(p.primary)),
        secondary: _adjustForDark(p.secondary),
        onSecondary: _getOnColor(_adjustForDark(p.secondary)),
        surface: darkSurface,
        onSurface: _getOnColor(darkSurface),
        background: darkBg,
        onBackground: _getOnColor(darkBg),
        error: p.error!,
        onError: _getOnColor(p.error!),
        outline: (p.outline ?? Colors.grey.shade600),
        outlineVariant: (p.outline ?? Colors.grey.shade600).withOpacity(.6),
        surfaceVariant: _adjustLightness(darkSurface, -.05),
        inverseSurface: Colors.white,
        onInverseSurface: Colors.black,
        inversePrimary: _adjustLightness(p.primary, -.2),
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

  // ====================== COMPONENT OVERRIDES (giữ nguyên từ bản cũ) ======================
  // Bạn có thể giữ hàm applyComponentThemes như cũ nếu muốn:
  static ThemeData applyComponentThemes(ThemeData base) {
    final colorScheme = base.colorScheme;
    final isDark = base.brightness == Brightness.dark;

    final bg = base.scaffoldBackgroundColor;
    final onBg = _getOnColor(bg);
    final overlay = ThemeData.estimateBrightnessForColor(bg) == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return base.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: bg,
        foregroundColor: onBg,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: overlay,
        titleTextStyle: (base.textTheme.titleLarge ?? const TextStyle())
            .copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: onBg),
        actionsIconTheme: IconThemeData(color: onBg, size: 24),
        iconTheme: IconThemeData(color: onBg, size: 24),
      ),
      cardTheme: CardThemeData(
        elevation: isDark ? 2 : 1,
        shadowColor: isDark ? Colors.black54 : Colors.black12,
        surfaceTintColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(8),
      ),
      // ... (các phần còn lại giữ nguyên từ code bạn – rút gọn để tránh dài)
    );
  }

  // ====================== Helpers ======================

  static Gradient _gradientFrom(Color a, Color b, bool dark) {
    // Placeholder dễ chịu; sau này có thể tinh chỉnh theo dark/light
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: dark
          ? [_adjustLightness(a, -0.04), _adjustLightness(b, -0.04)]
          : [_adjustLightness(a, 0.04), _adjustLightness(b, 0.04)],
    );
    // (Bước 2 sẽ dùng tokens này trong custom widgets)
  }

  static Color _generateContainer(Color base, bool dark) {
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

  static Color _generateTertiary(Color primary, Color secondary) {
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

  static Color _convertToDarkSurface(Color lightSurface) {
    final hsl = HSLColor.fromColor(lightSurface);
    return hsl
        .withLightness(0.12)
        .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  static Color _convertToDarkBackground(Color lightBackground) {
    final hsl = HSLColor.fromColor(lightBackground);
    return hsl
        .withLightness(0.06)
        .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  static Color _adjustForDark(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + 0.2).clamp(0.3, 0.9))
        .withSaturation((hsl.saturation * 1.1).clamp(0.0, 1.0))
        .toColor();
  }

  static Color _getOnColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  static Color _adjustLightness(Color color, double adjustment) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + adjustment).clamp(0.0, 1.0))
        .toColor();
  }

  static Gradient _backgroundGradient(ColorPalette p, bool dark) {
    // Tạo contrast rõ hơn: nền pha với primary
    final c1 = dark
        ? _adjustLightness(p.background, -0.12)
        : _adjustLightness(p.background, 0.08);
    final c2 = dark
        ? _adjustLightness(p.primary, -0.20)
        : _adjustLightness(p.primary, 0.12);

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [c1, c2],
    );
  }
}
