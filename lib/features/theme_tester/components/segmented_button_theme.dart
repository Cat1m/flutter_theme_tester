import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applySegmentedButtonTheme(
  ThemeData base,
  AppDecorationTokens tokens,
) {
  final cs = base.colorScheme;
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

  final segTheme = base.segmentedButtonTheme.copyWith(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(shape),
      side: MaterialStateProperty.resolveWith((states) {
        final selected = states.contains(MaterialState.selected);
        return BorderSide(
          color: selected ? cs.primary : cs.outline.withOpacity(.30),
        );
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        final selected = states.contains(MaterialState.selected);
        return selected ? cs.primary.withOpacity(.14) : Colors.transparent;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        final selected = states.contains(MaterialState.selected);
        return selected ? cs.primary : cs.onSurface;
      }),
      overlayColor: MaterialStateProperty.all(cs.primary.withOpacity(.08)),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    ),
  );

  return base.copyWith(segmentedButtonTheme: segTheme);
}
