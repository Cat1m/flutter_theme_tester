import 'package:flutter/material.dart';

@immutable
class AppDecorationTokens extends ThemeExtension<AppDecorationTokens> {
  final Gradient? backgroundGradient;
  final Gradient? buttonGradient;
  final Gradient? cardGradient;

  const AppDecorationTokens({
    this.backgroundGradient,
    this.buttonGradient,
    this.cardGradient,
  });

  @override
  AppDecorationTokens copyWith({
    Gradient? backgroundGradient,
    Gradient? buttonGradient,
    Gradient? cardGradient,
  }) {
    return AppDecorationTokens(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  AppDecorationTokens lerp(
    ThemeExtension<AppDecorationTokens>? other,
    double t,
  ) {
    if (other is! AppDecorationTokens) return this;
    return t < 0.5 ? this : other;
  }
}

/// extension tiện dụng
extension AppDecorationTokensX on BuildContext {
  AppDecorationTokens? get appTokens =>
      Theme.of(this).extension<AppDecorationTokens>();
}
