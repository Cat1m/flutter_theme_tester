import 'package:flutter/material.dart';
import '../../data/models/color_palette.dart';
import '../../data/models/theme_config.dart';
import '../../data/theme_store.dart';
import '../../themes/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeStore _store;
  ThemeConfig _config = ThemeConfig(
    mode: ThemeMode.system,
    palette: ColorPalette.defaults(),
  );

  ThemeProvider(this._store);

  AppTheme get appTheme => AppTheme(_config);
  ThemeMode get mode => _config.mode;
  ColorPalette get palette => _config.palette;

  Future<void> init() async {
    _config = await _store.load();
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    _config = _config.copyWith(mode: mode);
    await _store.save(_config);
    notifyListeners();
  }

  Future<void> setPalette(ColorPalette palette) async {
    _config = _config.copyWith(palette: palette);
    await _store.save(_config);
    notifyListeners();
  }
}
