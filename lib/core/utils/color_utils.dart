import 'package:flutter/material.dart';

Color parseHex(String input, {Color fallback = const Color(0xFF009688)}) {
  final hex = input.replaceAll('#', '').trim();
  if (hex.length == 6 || hex.length == 8) {
    final value = int.tryParse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
    if (value != null) return Color(value);
  }
  return fallback;
}
