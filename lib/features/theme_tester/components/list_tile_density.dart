import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyListTileDensity(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final listTile = base.listTileTheme.copyWith(
    dense: true,
    horizontalTitleGap: 10,
    minLeadingWidth: 20,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    iconColor: cs.onSurface.withOpacity(.74),
    textColor: cs.onSurface,
    selectedColor: cs.primary,
    selectedTileColor: cs.primary.withOpacity(.08),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    tileColor: base.scaffoldBackgroundColor,
  );

  return base.copyWith(listTileTheme: listTile);
}
