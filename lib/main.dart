import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_theme_tester/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomeAppSeed());
}

/// App seed rất mỏng để Step 1 chạy ngay.
class HomeAppSeed extends StatelessWidget {
  const HomeAppSeed({super.key});

  @override
  Widget build(BuildContext context) {
    return kReleaseMode
        ? const MyApp()
        : DevicePreview(enabled: true, builder: (_) => const MyApp());
  }
}
