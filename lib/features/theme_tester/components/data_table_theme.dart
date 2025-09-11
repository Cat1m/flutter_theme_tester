// lib/features/theme_tester/themes/components/data_table_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyDataTableTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;
  final isDark = base.brightness == Brightness.dark;

  final headingBg = isDark
      ? cs.surface.withValues(alpha: .80)
      : cs.surface; // đầu bảng
  final selectedRow = cs.primary.withValues(alpha: .08);

  final headingStyle = base.textTheme.labelLarge?.copyWith(
    fontWeight: FontWeight.w600,
    color: cs.onSurface,
  );

  final dataStyle = base.textTheme.bodyMedium?.copyWith(color: cs.onSurface);

  final tableTheme = base.dataTableTheme.copyWith(
    headingTextStyle: headingStyle,
    dataTextStyle: dataStyle,
    headingRowColor: WidgetStateProperty.resolveWith((states) => headingBg),
    dataRowColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected) ? selectedRow : null,
    ),
    dividerThickness: 1,
    horizontalMargin: 12,
    columnSpacing: 16,
  );

  return base.copyWith(dataTableTheme: tableTheme);
}
