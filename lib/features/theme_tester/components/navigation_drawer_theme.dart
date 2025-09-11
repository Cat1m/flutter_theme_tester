import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyNavigationDrawerTheme(
  ThemeData base,
  AppDecorationTokens tokens,
) {
  final cs = base.colorScheme;
  final onSurface = cs.onSurface;

  final drawerTheme = base.drawerTheme.copyWith(
    backgroundColor: base.scaffoldBackgroundColor,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
  );

  final navDrawerTheme = base.navigationDrawerTheme.copyWith(
    backgroundColor: base.scaffoldBackgroundColor,
    indicatorColor: cs.primary.withOpacity(.14),
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    tileHeight: 48,
    iconTheme: MaterialStateProperty.resolveWith((states) {
      final sel = states.contains(MaterialState.selected);
      return IconThemeData(
        color: sel ? cs.primary : onSurface.withOpacity(.74),
      );
    }),
    // textStyle: MaterialStateProperty.resolveWith((states) {
    //   final sel = states.contains(MaterialState.selected);
    //   return (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
    //     color: sel ? cs.primary : onSurface.withOpacity(.86),
    //     fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
    //   );
    // }),
    // shape: MaterialStatePropertyAll(
    //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    // ),
  );

  return base.copyWith(
    drawerTheme: drawerTheme,
    navigationDrawerTheme: navDrawerTheme,
  );
}
