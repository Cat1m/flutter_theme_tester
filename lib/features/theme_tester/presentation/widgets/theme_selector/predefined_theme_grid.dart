import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/predefined_palettes.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../../../../core/enums/predefined_themes.dart';

class PredefinedThemeGrid extends StatelessWidget {
  const PredefinedThemeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = PredefinedThemes.values;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        final t = items[index];
        final p = PredefinedPalettes.of(t);
        return _ThemeChip(
          label: PredefinedPalettes.labels[t]!,
          primary: p.primary,
          secondary: p.secondary,
          onTap: () => context.read<ThemeProvider>().setPalette(p),
        );
      },
    );
  }
}

class _ThemeChip extends StatelessWidget {
  final String label;
  final Color primary;
  final Color secondary;
  final VoidCallback onTap;

  const _ThemeChip({
    required this.label,
    required this.primary,
    required this.secondary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
