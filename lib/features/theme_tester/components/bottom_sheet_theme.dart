import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyBottomSheetTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final sheet = base.bottomSheetTheme.copyWith(
    backgroundColor: cs.surface,
    surfaceTintColor: cs.primary.withOpacity(.06),
    elevation: 2,
    modalElevation: 4,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    clipBehavior: Clip.antiAlias,
  );

  return base.copyWith(bottomSheetTheme: sheet);
}
