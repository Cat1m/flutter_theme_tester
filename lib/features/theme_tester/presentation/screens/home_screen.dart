// lib/features/theme_tester/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/color_input/four_color_input_form.dart';
import '../widgets/theme_selector/theme_mode_toggle.dart';
import '../widgets/theme_selector/predefined_theme_grid.dart';
import 'flex_preview_screen.dart';
import 'theme_preview_screen.dart';
import 'demo_screen.dart';
import 'theme_settings_screen.dart'; // 👈 import mới

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
              const Text(
                'Predefined Themes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const PredefinedThemeGrid(),
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
                    // 👇 nút mở Theme Settings
                    FilledButton.tonal(
                      onPressed: () => Navigator.of(inner).push(
                        MaterialPageRoute(
                          builder: (_) => const ThemeSettingsScreen(),
                        ),
                      ),
                      child: const Text('Theme Settings'),
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
