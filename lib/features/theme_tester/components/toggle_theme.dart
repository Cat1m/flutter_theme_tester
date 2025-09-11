import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyToggleThemes(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final switchTheme = base.switchTheme.copyWith(
    trackColor: MaterialStateProperty.resolveWith((states) {
      final sel = states.contains(MaterialState.selected);
      return sel ? cs.primary.withOpacity(.45) : cs.outline.withOpacity(.30);
    }),
    thumbColor: MaterialStateProperty.resolveWith((states) {
      final sel = states.contains(MaterialState.selected);
      return sel ? cs.primary : cs.onSurface;
    }),
  );

  final checkboxTheme = base.checkboxTheme.copyWith(
    side: BorderSide(color: cs.outline.withOpacity(.40), width: 1.2),
    fillColor: MaterialStateProperty.resolveWith((states) {
      final sel = states.contains(MaterialState.selected);
      return sel ? cs.primary : null; // null -> default
    }),
    checkColor: MaterialStateProperty.all(cs.onPrimary),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );

  final radioTheme = base.radioTheme.copyWith(
    fillColor: MaterialStateProperty.resolveWith((states) {
      final sel = states.contains(MaterialState.selected);
      return sel ? cs.primary : cs.onSurface.withOpacity(.70);
    }),
  );

  return base.copyWith(
    switchTheme: switchTheme,
    checkboxTheme: checkboxTheme,
    radioTheme: radioTheme,
  );
}
