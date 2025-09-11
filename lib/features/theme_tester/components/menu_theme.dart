import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyMenuThemes(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final dropdown = base.dropdownMenuTheme.copyWith(
    menuStyle: MenuStyle(
      elevation: const MaterialStatePropertyAll(6),
      backgroundColor: MaterialStatePropertyAll(cs.surface),
      surfaceTintColor: MaterialStatePropertyAll(cs.primary.withOpacity(.06)),
      shadowColor: MaterialStatePropertyAll(Colors.black.withOpacity(.18)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      side: MaterialStatePropertyAll(
        BorderSide(color: cs.outline.withOpacity(.20)),
      ),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(vertical: 6),
      ),
    ),
    inputDecorationTheme: base.inputDecorationTheme,
    textStyle: base.textTheme.bodyMedium,
  );

  // final menuBar = base.menuBarTheme.copyWith(
  //   style: MenuStyle(
  //     backgroundColor: MaterialStatePropertyAll(base.scaffoldBackgroundColor),
  //     elevation: const MaterialStatePropertyAll(0),
  //     padding: const MaterialStatePropertyAll(
  //       EdgeInsets.symmetric(horizontal: 6),
  //     ),
  //     shape: MaterialStatePropertyAll(
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     ),
  //   ),
  // );

  // final menuAnchor = base.menuTheme.copyWith(
  //   style: MenuStyle(
  //     elevation: const MaterialStatePropertyAll(6),
  //     backgroundColor: MaterialStatePropertyAll(cs.surface),
  //     surfaceTintColor: MaterialStatePropertyAll(cs.primary.withOpacity(.06)),
  //     shadowColor: MaterialStatePropertyAll(Colors.black.withOpacity(.18)),
  //     shape: MaterialStatePropertyAll(
  //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     ),
  //     side: MaterialStatePropertyAll(
  //       BorderSide(color: cs.outline.withOpacity(.20)),
  //     ),
  //     padding: const MaterialStatePropertyAll(
  //       EdgeInsets.symmetric(vertical: 6),
  //     ),
  //   ),
  // );

  return base.copyWith(
    dropdownMenuTheme: dropdown,
    // menuBarTheme: menuBar,
    // menuTheme: menuAnchor,
  );
}
