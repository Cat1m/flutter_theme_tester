// lib/features/theme_tester/presentation/screens/theme_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/app_theme_config.dart';
import '../../data/models/theme_enums.dart';
import '../providers/theme_provider.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Settings')),
      body: const _ThemeSettingsBody(),
    );
  }
}

class _ThemeSettingsBody extends StatelessWidget {
  const _ThemeSettingsBody();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();
    final ui = provider.ui;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Theme Engine',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        _EngineSelector(current: ui.engine),
        const SizedBox(height: 24),

        const Text(
          'Gradient Per Part',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        _GradientSwitchTile(
          title: 'Background',
          part: Part.background,
          value: ui.gradientBackground,
        ),
        _GradientSwitchTile(
          title: 'Button',
          part: Part.button,
          value: ui.gradientButton,
        ),
        _GradientSwitchTile(
          title: 'Card',
          part: Part.card,
          value: ui.gradientCard,
        ),
        const SizedBox(height: 24),

        // Optional: nút reset nhanh
        FilledButton.tonal(
          onPressed: () => provider.setUiConfig(
            const AppThemeConfig(engine: ThemeEngine.flex, gradientParts: {}),
          ),
          child: const Text('Reset to defaults'),
        ),
      ],
    );
  }
}

class _EngineSelector extends StatelessWidget {
  final ThemeEngine current;
  const _EngineSelector({required this.current});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ThemeProvider>();
    return Column(
      children: [
        RadioListTile<ThemeEngine>(
          title: const Text('Flex (flex_color_scheme)'),
          value: ThemeEngine.flex,
          groupValue: current,
          onChanged: (val) {
            if (val != null) provider.setEngine(val);
          },
        ),
        RadioListTile<ThemeEngine>(
          title: const Text('Vanilla (ThemeData/ColorScheme)'),
          value: ThemeEngine.vanilla,
          groupValue: current,
          onChanged: (val) {
            if (val != null) provider.setEngine(val);
          },
        ),
      ],
    );
  }
}

class _GradientSwitchTile extends StatelessWidget {
  final String title;
  final Part part;
  final bool value;

  const _GradientSwitchTile({
    required this.title,
    required this.part,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ThemeProvider>();
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (v) => provider.setPartEnabled(part, v),
    );
  }
}
