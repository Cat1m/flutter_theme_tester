// lib/features/theme_tester/themes/components/chip_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyChipTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;
  final isDark = base.brightness == Brightness.dark;

  final bg = isDark
      ? cs.surface.withValues(alpha: .70)
      : cs.surface; // nền chip mặc định
  final selectedBg = isDark
      ? cs.primary.withValues(alpha: .28)
      : cs.primary.withValues(alpha: .20);

  final label = base.textTheme.bodyMedium ?? const TextStyle(fontSize: 14);

  final chipTheme = base.chipTheme.copyWith(
    backgroundColor: bg,
    selectedColor: selectedBg,
    disabledColor: cs.onSurface.withValues(alpha: .12),
    checkmarkColor: cs.onPrimary,
    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    labelStyle: label.copyWith(color: cs.onSurface),
    secondaryLabelStyle: label.copyWith(
      color: cs.onPrimary,
      fontWeight: FontWeight.w600,
    ),
    deleteIconColor: cs.onSurface.withValues(alpha: .70),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: cs.outline.withValues(alpha: .30), width: 1),
    ),
    side: BorderSide(color: cs.outline.withValues(alpha: .30), width: 1),
    brightness: base.brightness, // giữ nhất quán
    elevation: 0,
    pressElevation: 0,
    selectedShadowColor: Colors.transparent,
    shadowColor: Colors.transparent,
    surfaceTintColor: cs.primary,
  );

  return base.copyWith(chipTheme: chipTheme);
}
