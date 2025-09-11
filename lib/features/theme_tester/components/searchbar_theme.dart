import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applySearchBarTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final searchBar = base.searchBarTheme.copyWith(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: MaterialStatePropertyAll(cs.surface),
    surfaceTintColor: MaterialStatePropertyAll(cs.primary.withOpacity(.08)),
    shadowColor: const MaterialStatePropertyAll(Colors.transparent),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    hintStyle: MaterialStatePropertyAll(
      (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
        color: cs.onSurface.withOpacity(.55),
      ),
    ),
    textStyle: MaterialStatePropertyAll(
      (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
        color: cs.onSurface,
      ),
    ),
  );

  final searchView = base.searchViewTheme.copyWith(
    headerHintStyle: (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
      color: cs.onSurface.withOpacity(.55),
    ),
    headerTextStyle: (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
      color: cs.onSurface,
    ),
    dividerColor: cs.outline.withOpacity(.20),
    //headerBackgroundColor: cs.surface,
    surfaceTintColor: cs.primary.withOpacity(.06),
    constraints: const BoxConstraints(maxWidth: 720),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  return base.copyWith(searchBarTheme: searchBar, searchViewTheme: searchView);
}
