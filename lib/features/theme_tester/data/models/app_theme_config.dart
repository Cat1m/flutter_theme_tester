import 'package:flutter/material.dart';
import 'theme_enums.dart';

@immutable
class AppThemeConfig {
  final ThemeEngine engine;
  final Set<Part> gradientParts;

  const AppThemeConfig({required this.engine, this.gradientParts = const {}});

  bool get gradientBackground => gradientParts.contains(Part.background);
  bool get gradientButton => gradientParts.contains(Part.button);
  bool get gradientCard => gradientParts.contains(Part.card);

  AppThemeConfig copyWith({ThemeEngine? engine, Set<Part>? gradientParts}) {
    return AppThemeConfig(
      engine: engine ?? this.engine,
      gradientParts: gradientParts ?? this.gradientParts,
    );
  }

  static const AppThemeConfig defaults = AppThemeConfig(
    engine: ThemeEngine.flex, // default: dùng flex
    gradientParts: {}, // default: chưa bật gradient phần nào
  );
}
