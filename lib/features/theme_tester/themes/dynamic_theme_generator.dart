import 'package:flutter/material.dart';
import '../data/models/color_palette.dart';

class DynamicThemeGenerator {
  // Gengar reference colors (để nhận diện palette Gengar)
  static const _gengarPrimary = Color(0xFF5B3A91);
  static const _gengarSecondary = Color(0xFF8E5BD5);
  static const _gengarSurfaceLt = Color(0xFFFFFFFF);
  static const _gengarBgLt = Color(0xFFF5F0FF);

  static bool _isGengar(ColorPalette p) =>
      p.primary.value == _gengarPrimary.value &&
      p.secondary.value == _gengarSecondary.value &&
      p.surface.value == _gengarSurfaceLt.value &&
      p.background.value == _gengarBgLt.value;

  /// Tạo ThemeData từ 4 màu. Nếu là Gengar thì override ColorScheme (light/dark).
  static ThemeData fromPalette(ColorPalette palette, {bool dark = false}) {
    // Base: Material 3 từ seed
    var scheme = ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: dark ? Brightness.dark : Brightness.light,
      // background/surface sẽ được copyWith lại bên dưới nếu Gengar
    );

    if (_isGengar(palette)) {
      if (!dark) {
        // LIGHT — tím đậm, nền lavender, tăng tương phản chữ
        scheme = scheme.copyWith(
          primary: _gengarPrimary,
          onPrimary: Colors.white,
          secondary: _gengarSecondary,
          onSecondary: Colors.white,
          surface: const Color(0xFFFCFAFF), // surface sáng nhẹ hơn mặc định
          onSurface: const Color(
            0xFF1A132B,
          ), // tím rất đậm (eggplant) cho contrast
          surfaceTint:
              _gengarPrimary, // tonal elevation: tím hoá surface khi nâng
          outline: const Color(0xFFBFA6E6), // nét viền tím nhạt
          primaryContainer: const Color(0xFFD7C7FF),
          onPrimaryContainer: const Color(0xFF28194A),
          secondaryContainer: const Color(0xFFEAD9FF),
          onSecondaryContainer: const Color(0xFF2D1C54),
        );
      } else {
        // DARK — tím đậm huyền bí, giữ readability cao
        scheme = scheme.copyWith(
          primary: const Color(0xFFB598FF), // tím sáng cho dark
          onPrimary: const Color(0xFF2A1D4C),
          secondary: const Color(0xFFD4B8FF),
          onSecondary: const Color(0xFF2A1D4C), // very dark eggplant
          surface: const Color(0xFF151024), // dark surface nâng nhẹ
          onSurface: const Color(0xFFEDE7F6),
          surfaceTint: _gengarPrimary, // tint tím khi elevate
          outline: const Color(0xFF6F5E90),
          primaryContainer: const Color(0xFF3B2C63),
          onPrimaryContainer: const Color(0xFFEBDDFF),
          secondaryContainer: const Color(0xFF45346E),
          onSecondaryContainer: const Color(0xFFF2E7FF),
        );
      }
    } else {
      // Non-Gengar: tôn trọng palette (background/surface theo người dùng)
      scheme = scheme.copyWith(surface: palette.surface);
    }

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      // surfaceTintColor ở ThemeData được nhiều widget M3 sử dụng cho tonal elevation
      // (AppBar/Sheet/Card… sẽ dựa vào colorScheme.surfaceTint)
      // Các component themes chi tiết áp bên dưới qua applyComponentThemes().
    );
  }

  /// Tuỳ chỉnh các component để ăn tonal elevation & contrast tốt hơn.
  static ThemeData applyComponentThemes(ThemeData base) {
    final cs = base.colorScheme;

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        surfaceTintColor: cs.surfaceTint,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 1, // thấp để thấy nhẹ surfaceTint
        surfaceTintColor: cs.surfaceTint,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(2),
          surfaceTintColor: WidgetStateProperty.all(cs.surfaceTint),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: WidgetStateProperty.all(BorderSide(color: cs.outline)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        hintStyle: TextStyle(color: cs.onSurface.withValues(alpha: .6)),
        labelStyle: TextStyle(color: cs.onSurface.withValues(alpha: .9)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.primary, width: 1.6),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.error),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.error, width: 1.6),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        indicatorColor: cs.secondaryContainer,
        labelTextStyle: WidgetStateProperty.all(TextStyle(color: cs.onSurface)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
        actionTextColor: cs.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
