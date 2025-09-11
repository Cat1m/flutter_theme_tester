import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/providers/theme_provider.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/screens/compare_theme_page.dart';
import 'package:provider/provider.dart';

import '../widgets/color_input/four_color_input_form.dart';
import '../widgets/theme_selector/theme_mode_toggle.dart';
// XÓA: import '../widgets/theme_selector/predefined_theme_grid.dart';
import '../widgets/theme_selector/predefined_theme_dropdown.dart';

import 'flex_preview_screen.dart';
import 'theme_preview_screen.dart';
import 'demo_screen.dart';
import 'theme_settings_screen.dart';

// Lấy config hiện tại để build 2 case
import '../../themes/dynamic_theme_generator.dart';
import '../../themes/../data/models/theme_enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Tester (Lite)')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ThemeModeToggle(),
              const SizedBox(height: 16),
              const FourColorInputForm(),
              const SizedBox(height: 16),

              // ⬇️ Đổi Grid -> Dropdown
              const PredefinedThemeDropdown(),
              const SizedBox(height: 16),

              Builder(
                builder: (inner) => Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton(
                      onPressed: () => Navigator.of(inner).push(
                        MaterialPageRoute(
                          builder: (_) => const ThemePreviewScreen(),
                        ),
                      ),
                      child: const Text('Xem Preview (Lite)'),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.of(inner).push(
                        MaterialPageRoute(
                          builder: (_) => const FlexPreviewScreen(),
                        ),
                      ),
                      child: const Text('Flex Preview (M3)'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(inner).push(
                        MaterialPageRoute(builder: (_) => const DemoScreen()),
                      ),
                      child: const Text('Demo Gradient'),
                    ),
                    FilledButton.tonal(
                      onPressed: () => Navigator.of(inner).push(
                        MaterialPageRoute(
                          builder: (_) => const ThemeSettingsScreen(),
                        ),
                      ),
                      child: const Text('Theme Settings'),
                    ),

                    // 🆕 Nút so sánh Flex vs Vanilla
                    OutlinedButton.icon(
                      icon: const Icon(Icons.compare_arrows),
                      label: const Text('So sánh Flex vs Vanilla'),
                      onPressed: () {
                        final provider = context.read<ThemeProvider>();
                        final cfg =
                            provider.themeConfig; // ThemeConfig hiện tại
                        final palette = cfg.palette;
                        final ui = cfg.ui;

                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;

                        final themeFlex = DynamicThemeGenerator.fromPalette(
                          palette,
                          config: ui.copyWith(engine: ThemeEngine.flex),
                          dark: isDark,
                        );
                        final themeVanilla = DynamicThemeGenerator.fromPalette(
                          palette,
                          config: ui.copyWith(engine: ThemeEngine.vanilla),
                          dark: isDark,
                        );

                        Navigator.of(inner).push(
                          MaterialPageRoute(
                            builder: (_) => CompareThemePage(
                              themeFlex: themeFlex,
                              themeVanilla: themeVanilla,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
