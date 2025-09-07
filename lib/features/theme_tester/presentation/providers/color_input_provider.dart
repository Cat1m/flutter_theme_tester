import 'package:flutter/material.dart';
import '../../data/models/color_palette.dart';

class ColorInputProvider extends ChangeNotifier {
  String hexPrimary = '#009688';
  String hexSecondary = '#26A69A';
  String hexSurface = '#FFFFFF';
  String hexBackground = '#F2F2F2';

  void update({
    String? primary,
    String? secondary,
    String? surface,
    String? background,
  }) {
    if (primary != null) hexPrimary = primary;
    if (secondary != null) hexSecondary = secondary;
    if (surface != null) hexSurface = surface;
    if (background != null) hexBackground = background;
    notifyListeners();
  }

  ColorPalette toPalette(Color Function(String) parser) => ColorPalette(
    primary: parser(hexPrimary),
    secondary: parser(hexSecondary),
    surface: parser(hexSurface),
    background: parser(hexBackground),
  );
}
