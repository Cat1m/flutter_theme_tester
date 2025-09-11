import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';
import '../utils/color_utils.dart';

ThemeData applyAppBarTheme(ThemeData base, AppDecorationTokens tokens) {
  final bg = base.scaffoldBackgroundColor;
  final onBg = ColorUtils.getOnColor(bg);
  final overlay = ThemeData.estimateBrightnessForColor(bg) == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;

  return base.copyWith(
    appBarTheme: base.appBarTheme.copyWith(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: bg,
      foregroundColor: onBg,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: overlay,
      titleTextStyle: (base.textTheme.titleLarge ?? const TextStyle()).copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onBg,
      ),
      iconTheme: IconThemeData(color: onBg, size: 24),
      actionsIconTheme: IconThemeData(color: onBg, size: 24),
    ),
  );
}
