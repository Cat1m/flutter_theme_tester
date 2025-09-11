import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/app_bar_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/badge_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/bottom_sheet_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/button_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/card_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/chip_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/data_table_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/dialog_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/fab_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/input_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/list_tile_density.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/menu_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/navigation_drawer_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/navigation_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/pickers_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/popup_menu_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/searchbar_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/segmented_button_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/slider_progress_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/toggle_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/components/tooltip_snack_theme.dart';
import 'package:flutter_theme_tester/features/theme_tester/engines/flex_engine.dart';
import 'package:flutter_theme_tester/features/theme_tester/engines/vanilla_engine.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';
import 'package:flutter_theme_tester/features/theme_tester/utils/gradients.dart';

import '../data/models/color_palette.dart';
import '../data/models/app_theme_config.dart';
import '../data/models/theme_enums.dart';

class DynamicThemeGenerator {
  static ThemeData fromPalette(
    ColorPalette palette, {
    required AppThemeConfig config,
    bool dark = false,
  }) {
    final p = palette.withFallbacks();

    // Create tokens (reusing your existing AppDecorationTokens)
    final tokens = AppDecorationTokens(
      backgroundGradient: config.gradientBackground
          ? Gradients.background(p, dark)
          : null,
      buttonGradient: config.gradientButton
          ? Gradients.duo(p.primary, p.secondary, dark)
          : null,
      cardGradient: config.gradientCard
          ? Gradients.duo(p.surface, p.background, dark)
          : null,
    );

    // Build base engine theme
    ThemeData base;
    switch (config.engine) {
      case ThemeEngine.flex:
        base = FlexEngine.build(p: p, dark: dark);
        break;
      case ThemeEngine.vanilla:
        base = VanillaEngine.build(p: p, dark: dark);
        break;
    }

    // Attach extensions (tokens first, then existing)
    base = base.copyWith(extensions: [tokens, ...base.extensions.values]);

    // Apply shared component overrides
    base = applyAppBarTheme(base, tokens);
    base = applyButtonTheme(base, tokens);
    base = applyCardTheme(base, tokens);
    base = applyInputTheme(base, tokens);
    base = applyChipTheme(base, tokens);
    base = applyDataTableTheme(base, tokens);
    base = applyNavigationThemes(base, tokens);
    base = applySegmentedButtonTheme(base, tokens);
    base = applyTooltipAndSnackThemes(base, tokens);
    base = applyToggleThemes(base, tokens);
    base = applySliderAndProgressThemes(base, tokens);
    base = applyNavigationDrawerTheme(base, tokens);
    base = applyDialogTheme(base, tokens);
    base = applyPickersTheme(base, tokens);
    base = applyBadgeTheme(base, tokens);
    base = applyListTileDensity(base, tokens);
    base = applySearchBarTheme(base, tokens);
    base = applyMenuThemes(base, tokens);
    base = applyPopupMenuTheme(base, tokens);
    base = applyFabTheme(base, tokens);
    base = applyBottomSheetTheme(base, tokens);
    return base;
  }
}
