import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyFabTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final fab = base.floatingActionButtonTheme.copyWith(
    backgroundColor: cs.primary,
    foregroundColor: cs.onPrimary,
    elevation: 3,
    focusElevation: 4,
    hoverElevation: 4,
    highlightElevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  // final extFab =
  //     base.extendedFloatingActionButtonTheme?.copyWith(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStatePropertyAll(cs.primary),
  //         foregroundColor: MaterialStatePropertyAll(cs.onPrimary),
  //         elevation: const MaterialStatePropertyAll(3),
  //         shape: MaterialStatePropertyAll(
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //         ),
  //         padding: const MaterialStatePropertyAll(
  //           EdgeInsets.symmetric(horizontal: 18, vertical: 12),
  //         ),
  //       ),
  //     ) ??
  //     const ExtendedFloatingActionButtonThemeData();

  return base.copyWith(
    floatingActionButtonTheme: fab,
    //extendedFloatingActionButtonTheme: extFab,
  );
}
