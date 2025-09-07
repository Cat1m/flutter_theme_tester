import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ThemeModeToggle extends StatelessWidget {
  const ThemeModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();
    return Row(
      children: [
        const Text('Theme Mode:'),
        const SizedBox(width: 12),
        SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(value: ThemeMode.light, label: Text('Light')),
            ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
            ButtonSegment(value: ThemeMode.system, label: Text('System')),
          ],
          selected: {provider.mode},
          onSelectionChanged: (s) => provider.setMode(s.first),
        ),
      ],
    );
  }
}
