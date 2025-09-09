import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor; // fallback khi không dùng gradient
  final bool useGradientIfAvailable; // cho phép tắt gradient theo từng màn

  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.useGradientIfAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.appTokens;
    final gradient = (useGradientIfAvailable)
        ? tokens?.backgroundGradient
        : null;
    final scaffoldBg = Theme.of(context).scaffoldBackgroundColor;

    if (gradient == null) {
      // Không có gradient nền → Scaffold bình thường
      return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        backgroundColor: backgroundColor ?? scaffoldBg,
      );
    }

    // Có gradient nền → vẽ Container gradient sau lưng, Scaffold trong suốt
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.transparent,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
      ),
    );
  }
}
