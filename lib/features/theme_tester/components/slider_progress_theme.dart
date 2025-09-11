import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applySliderAndProgressThemes(
  ThemeData base,
  AppDecorationTokens tokens,
) {
  final cs = base.colorScheme;

  final slider = base.sliderTheme.copyWith(
    trackHeight: 4,
    activeTrackColor: cs.primary,
    inactiveTrackColor: cs.outline.withOpacity(.30),
    thumbColor: cs.primary,
    overlayColor: cs.primary.withOpacity(.12),
    valueIndicatorColor: cs.primary,
    valueIndicatorTextStyle: (base.textTheme.labelSmall ?? const TextStyle())
        .copyWith(color: cs.onPrimary),
    rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 2),
  );

  final progress = base.progressIndicatorTheme.copyWith(
    color: cs.primary,
    linearTrackColor: cs.outline.withOpacity(.20),
    circularTrackColor: cs.outline.withOpacity(.20),
  );

  return base.copyWith(sliderTheme: slider, progressIndicatorTheme: progress);
}
