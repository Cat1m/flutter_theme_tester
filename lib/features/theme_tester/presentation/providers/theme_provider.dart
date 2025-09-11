// lib/features/theme_tester/presentation/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/data/models/app_theme_config.dart';
import '../../data/models/color_palette.dart';
import '../../data/models/theme_config.dart';
import '../../data/theme_store.dart';
import '../../themes/app_theme.dart';
import '../../data/models/theme_enums.dart'; // <- dùng ThemeEngine & Part

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

  // 👇 Thêm getter để lấy UI config hiện tại
  AppThemeConfig get ui => _config.ui;

  ThemeConfig get themeConfig => _config;

  Future<void> init() async {
    _config = await _store.load();

    // Nếu muốn mặc định bật background + button ngay lần đầu:
    if (_config.ui.gradientParts.isEmpty) {
      _config = _config.copyWith(
        ui: _config.ui.copyWith(gradientParts: {Part.background, Part.button}),
      );
    }

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

  Future<void> setUiConfig(AppThemeConfig ui) async {
    _config = _config.copyWith(ui: ui);
    await _store.save(_config);
    notifyListeners();
  }

  // 👇 Helper: set engine
  Future<void> setEngine(ThemeEngine engine) async {
    await setUiConfig(_config.ui.copyWith(engine: engine));
  }

  // 👇 Helper: bật/tắt một Part (background/button/card)
  Future<void> setPartEnabled(Part part, bool enabled) async {
    final current = _config.ui.gradientParts;
    final updated = <Part>{...current};
    if (enabled) {
      updated.add(part);
    } else {
      updated.remove(part);
    }
    await setUiConfig(_config.ui.copyWith(gradientParts: updated));
  }
}
