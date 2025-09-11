import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyPopupMenuTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final popup = base.popupMenuTheme.copyWith(
    elevation: 6,
    color: cs.surface,
    surfaceTintColor: cs.primary.withOpacity(.06),
    shadowColor: Colors.black.withOpacity(.18),
    textStyle: base.textTheme.bodyMedium,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  return base.copyWith(popupMenuTheme: popup);
}
