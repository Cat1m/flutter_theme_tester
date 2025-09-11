import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyDialogTheme(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;

  final dialogData = DialogThemeData(
    // Đổi từ DialogTheme thành DialogThemeData
    elevation: 2,
    backgroundColor: base.colorScheme.surface,
    surfaceTintColor: cs.primary.withOpacity(.10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: (base.textTheme.titleLarge ?? const TextStyle()).copyWith(
      fontWeight: FontWeight.w700,
      color: cs.onSurface,
    ),
    contentTextStyle: (base.textTheme.bodyMedium ?? const TextStyle()).copyWith(
      color: cs.onSurface.withOpacity(.92),
    ),
    actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
  );

  return base.copyWith(
    dialogTheme: dialogData, // Chỉ còn dialogTheme, không có alertDialogTheme
  );
}
