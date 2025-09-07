import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/core/utils/color_utils.dart';
import 'package:provider/provider.dart';
import '../../providers/color_input_provider.dart';
import '../../providers/theme_provider.dart';

class FourColorInputForm extends StatelessWidget {
  const FourColorInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorInput = context.watch<ColorInputProvider>();
    final theme = context.read<ThemeProvider>();

    Widget buildHex(String label, String value, void Function(String) cb) =>
        TextField(
          decoration: InputDecoration(labelText: label, prefixText: '#'),
          controller: TextEditingController(text: value.replaceAll('#', '')),
          onChanged: (v) => cb('#${v.replaceAll('#', '')}'),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHex(
          'Primary',
          colorInput.hexPrimary,
          (v) => colorInput.update(primary: v),
        ),
        const SizedBox(height: 8),
        buildHex(
          'Secondary',
          colorInput.hexSecondary,
          (v) => colorInput.update(secondary: v),
        ),
        const SizedBox(height: 8),
        buildHex(
          'Surface',
          colorInput.hexSurface,
          (v) => colorInput.update(surface: v),
        ),
        const SizedBox(height: 8),
        buildHex(
          'Background',
          colorInput.hexBackground,
          (v) => colorInput.update(background: v),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {
            final palette = colorInput.toPalette((s) => parseHex(s));
            theme.setPalette(palette);
          },
          child: const Text('Áp dụng màu'),
        ),
      ],
    );
  }
}
