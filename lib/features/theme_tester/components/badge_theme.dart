import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyBadgeTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final badge = base.badgeTheme.copyWith(
    backgroundColor: cs.error,
    textColor: cs.onError,
    largeSize: 20,
    smallSize: 16,
    alignment: const AlignmentDirectional(12, -12),
    padding: const EdgeInsets.symmetric(horizontal: 6),
    textStyle: (base.textTheme.labelSmall ?? const TextStyle(fontSize: 10))
        .copyWith(fontWeight: FontWeight.w700),
  );

  return base.copyWith(badgeTheme: badge);
}
