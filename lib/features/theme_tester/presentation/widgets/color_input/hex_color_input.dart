import 'package:flutter/material.dart';

class HexColorInput extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const HexColorInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label, prefixText: '#'),
      controller: TextEditingController(text: value.replaceAll('#', '')),
      onChanged: (v) => onChanged('#${v.replaceAll('#', '')}'),
    );
  }
}
