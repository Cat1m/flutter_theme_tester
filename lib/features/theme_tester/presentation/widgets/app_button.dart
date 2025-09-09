import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool useGradientIfAvailable;
  final ButtonStyle? fallbackStyle; // style khi không dùng gradient

  const AppButton.primary({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.borderRadius = 12,
    this.useGradientIfAvailable = true,
    this.fallbackStyle,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.appTokens;
    final gradient = (useGradientIfAvailable) ? tokens?.buttonGradient : null;
    final radius = BorderRadius.circular(borderRadius);

    // Disabled state
    final isDisabled = onPressed == null;

    if (gradient == null) {
      // Không bật gradient → dùng ElevatedButton (giữ semantics & states)
      return ElevatedButton(
        onPressed: onPressed,
        style:
            fallbackStyle ??
            ElevatedButton.styleFrom(
              padding: padding,
              shape: RoundedRectangleBorder(borderRadius: radius),
              minimumSize: const Size(88, 48),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
        child: child,
      );
    }

    // Có gradient → custom Material + InkWell
    final cs = Theme.of(context).colorScheme;
    final onGradientColor =
        cs.onPrimary; // đoán chữ trên nền nút; có thể tinh chỉnh

    // Nếu disabled → giảm opacity
    final double opacity = isDisabled ? 0.5 : 1.0;

    return Opacity(
      opacity: opacity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: radius,
          boxShadow: kElevationToShadow[isDisabled ? 0 : 2],
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: isDisabled ? null : onPressed,
            child: Padding(
              padding: padding,
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: onGradientColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                child: IconTheme.merge(
                  data: IconThemeData(color: onGradientColor),
                  child: Center(child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
