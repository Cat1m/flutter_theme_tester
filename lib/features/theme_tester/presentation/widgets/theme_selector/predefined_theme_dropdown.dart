import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../themes/predefined_palettes.dart';
import '../../../data/models/color_palette.dart';

import '../../../../../core/enums/predefined_themes.dart';

class PredefinedThemeDropdown extends StatefulWidget {
  const PredefinedThemeDropdown({super.key});

  @override
  State<PredefinedThemeDropdown> createState() =>
      _PredefinedThemeDropdownState();
}

class _PredefinedThemeDropdownState extends State<PredefinedThemeDropdown> {
  PredefinedThemes? _selected;

  @override
  void initState() {
    super.initState();
    // Lấy palette hiện tại để set selected ban đầu (nếu bạn muốn sync)
    // Nếu ThemeProvider có sẵn loại đang chọn thì dùng thẳng từ đó.
    // Ở đây default = item đầu.
    _selected ??= PredefinedThemes.values.first;
  }

  @override
  Widget build(BuildContext context) {
    final items = PredefinedThemes.values;

    return DropdownButtonFormField<PredefinedThemes>(
      value: _selected,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Predefined Themes',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: items.map((t) {
        final p = PredefinedPalettes.of(t);
        final label = PredefinedPalettes.labels[t]!;
        return DropdownMenuItem<PredefinedThemes>(
          value: t,
          child: _SwatchLabel(label: label, palette: p),
        );
      }).toList(),
      onChanged: (val) {
        if (val == null) return;
        setState(() => _selected = val);
        final p = PredefinedPalettes.of(val);
        context.read<ThemeProvider>().setPalette(p);
      },
    );
  }
}

class _SwatchLabel extends StatelessWidget {
  final String label;
  final ColorPalette palette;

  const _SwatchLabel({required this.label, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _swatch(palette.primary),
        const SizedBox(width: 6),
        _swatch(palette.secondary),
        const SizedBox(width: 10),
        Expanded(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _swatch(Color c) => Container(
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.black12),
    ),
  );
}
