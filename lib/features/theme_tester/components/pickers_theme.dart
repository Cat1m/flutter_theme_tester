import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyPickersTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;
  final txt = base.textTheme;

  final datePicker = base.datePickerTheme.copyWith(
    backgroundColor: base.colorScheme.surface,
    surfaceTintColor: cs.primary.withOpacity(.10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    headerBackgroundColor: cs.primary.withOpacity(.10),
    headerForegroundColor: cs.onSurface,
    dayForegroundColor: MaterialStateProperty.resolveWith((states) {
      final sel = states.contains(MaterialState.selected);
      return sel ? cs.onPrimary : cs.onSurface;
    }),
    dayOverlayColor: MaterialStateProperty.all(cs.primary.withOpacity(.08)),
    todayForegroundColor: MaterialStateProperty.all(cs.primary),
    rangePickerBackgroundColor: base.colorScheme.surface,
  );

  final timePicker = base.timePickerTheme.copyWith(
    backgroundColor: base.colorScheme.surface,
    hourMinuteTextColor: cs.onSurface,
    dialHandColor: cs.primary,
    dialBackgroundColor: cs.primary.withOpacity(.12),
    dayPeriodBorderSide: BorderSide(color: cs.outline.withOpacity(.30)),
    helpTextStyle: (txt.labelLarge ?? const TextStyle()).copyWith(
      color: cs.onSurface.withOpacity(.74),
      fontWeight: FontWeight.w600,
    ),
    entryModeIconColor: cs.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  return base.copyWith(
    datePickerTheme: datePicker,
    timePickerTheme: timePicker,
  );
}
