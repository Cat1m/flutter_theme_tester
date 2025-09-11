// lib/features/theme_tester/themes/components/input_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyInputTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;
  final isDark = base.brightness == Brightness.dark;
  const radius = 12.0;

  OutlineInputBorder outline(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: color, width: 1),
  );

  final fill = isDark
      ? cs.surface.withValues(alpha: .90)
      : cs.surface; // an toàn trên mọi channel Flutter

  final inputTheme = base.inputDecorationTheme.copyWith(
    isDense: true,
    filled: true,
    fillColor: fill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: outline(cs.outline.withValues(alpha: .30)),
    enabledBorder: outline(cs.outline.withValues(alpha: .30)),
    disabledBorder: outline(cs.outline.withValues(alpha: .18)),
    focusedBorder: outline(cs.primary),
    errorBorder: outline(cs.error),
    focusedErrorBorder: outline(cs.error),
    labelStyle: base.textTheme.bodyMedium?.copyWith(
      color: cs.onSurface.withValues(alpha: .70),
    ),
    hintStyle: base.textTheme.bodyMedium?.copyWith(
      color: cs.onSurface.withValues(alpha: .50),
    ),
    helperStyle: base.textTheme.bodySmall?.copyWith(
      color: cs.onSurface.withValues(alpha: .60),
    ),
    errorStyle: base.textTheme.bodySmall?.copyWith(
      color: cs.error,
      fontWeight: FontWeight.w600,
    ),
    prefixIconColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.focused)
          ? cs.primary
          : cs.onSurface.withValues(alpha: .60),
    ),
    suffixIconColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.focused)
          ? cs.primary
          : cs.onSurface.withValues(alpha: .60),
    ),
  );

  return base.copyWith(
    inputDecorationTheme: inputTheme,
    textSelectionTheme: base.textSelectionTheme.copyWith(
      cursorColor: cs.primary,
      selectionColor: cs.primary.withValues(alpha: .25),
      selectionHandleColor: cs.primary,
    ),
  );
}
