import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyTooltipAndSnackThemes(
  ThemeData base,
  AppDecorationTokens tokens,
) {
  final cs = base.colorScheme;
  final isDark = base.brightness == Brightness.dark;

  final tooltip = base.tooltipTheme.copyWith(
    waitDuration: const Duration(milliseconds: 300),
    showDuration: const Duration(milliseconds: 3500),
    textStyle: (base.textTheme.labelSmall ?? const TextStyle()).copyWith(
      color: isDark ? Colors.black : Colors.white,
      fontWeight: FontWeight.w500,
    ),
    decoration: BoxDecoration(
      color: isDark ? Colors.white : Colors.black,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.12), blurRadius: 8),
      ],
    ),
  );

  final snack = base.snackBarTheme.copyWith(
    behavior: SnackBarBehavior.floating,
    elevation: 2,
    backgroundColor: cs.inverseSurface,
    contentTextStyle: (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
      color: cs.onInverseSurface,
    ),
    actionTextColor: cs.inversePrimary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  return base.copyWith(tooltipTheme: tooltip, snackBarTheme: snack);
}
