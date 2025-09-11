import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

ThemeData applyNavigationThemes(ThemeData base, AppDecorationTokens tokens) {
  final cs = base.colorScheme;
  final onSurface = cs.onSurface;

  // Material 3 NavigationBar
  final navBarTheme = base.navigationBarTheme.copyWith(
    elevation: 0,
    backgroundColor: base.scaffoldBackgroundColor,
    surfaceTintColor: Colors.transparent,
    indicatorColor: cs.primary.withOpacity(.14),
    iconTheme: MaterialStateProperty.resolveWith((states) {
      final color = states.contains(MaterialState.selected)
          ? cs.primary
          : onSurface.withOpacity(.74);
      return IconThemeData(color: color);
    }),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    labelTextStyle: MaterialStateProperty.resolveWith((states) {
      final isSel = states.contains(MaterialState.selected);
      return (base.textTheme.labelMedium ?? const TextStyle()).copyWith(
        color: isSel ? cs.primary : onSurface.withOpacity(.74),
        fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
      );
    }),
  );

  // NavigationRail
  final railTheme = base.navigationRailTheme.copyWith(
    backgroundColor: base.scaffoldBackgroundColor,
    indicatorColor: cs.primary.withOpacity(.14),
    useIndicator: true,
    elevation: 0,
    labelType: NavigationRailLabelType.all,
    selectedIconTheme: IconThemeData(color: cs.primary),
    unselectedIconTheme: IconThemeData(color: onSurface.withOpacity(.74)),
    selectedLabelTextStyle: (base.textTheme.labelMedium ?? const TextStyle())
        .copyWith(color: cs.primary, fontWeight: FontWeight.w600),
    unselectedLabelTextStyle: (base.textTheme.labelMedium ?? const TextStyle())
        .copyWith(
          color: onSurface.withOpacity(.74),
          fontWeight: FontWeight.w500,
        ),
  );

  // TabBar
  final tabTheme = base.tabBarTheme.copyWith(
    indicatorSize: TabBarIndicatorSize.label,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: cs.primary, width: 2.5),
    ),
    labelColor: cs.primary,
    unselectedLabelColor: onSurface.withOpacity(.74),
    labelStyle:
        (base.textTheme.titleSmall ??
        const TextStyle(fontWeight: FontWeight.w600)),
    unselectedLabelStyle:
        (base.textTheme.titleSmall ??
        const TextStyle(fontWeight: FontWeight.w500)),
  );

  return base.copyWith(
    navigationBarTheme: navBarTheme,
    navigationRailTheme: railTheme,
    tabBarTheme: tabTheme,
  );
}
