import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyCardTheme(ThemeData base, AppDecorationTokens tokens) {
  final isDark = base.brightness == Brightness.dark;
  return base.copyWith(
    cardTheme: base.cardTheme.copyWith(
      elevation: isDark ? 2 : 1,
      shadowColor: isDark ? Colors.black54 : Colors.black12,
      surfaceTintColor: base.colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
    ),
  );
}
