import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyButtonTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final common = ButtonStyle(
    shape: WidgetStateProperty.all(const StadiumBorder()),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return cs.onSurface.withValues(alpha: .12);
      }
      return cs.primary;
    }),
    foregroundColor: WidgetStateProperty.all(cs.onPrimary),
  );

  return base.copyWith(
    filledButtonTheme: FilledButtonThemeData(style: common),
    elevatedButtonTheme: ElevatedButtonThemeData(style: common),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(cs.primary)),
    ),
  );
}
