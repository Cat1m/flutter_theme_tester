import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/data/theme_store.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/providers/color_input_provider.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/providers/theme_provider.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(ThemeStore())..init(),
        ),
        ChangeNotifierProvider(create: (_) => ColorInputProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final theme = themeProvider.appTheme;
          return MaterialApp(
            title: 'Flutter Theme Tester',
            debugShowCheckedModeBanner: false,
            // ⚠️ DevicePreview vẫn yêu cầu
            // ignore: deprecated_member_use
            useInheritedMediaQuery: !kReleaseMode,
            builder: !kReleaseMode ? DevicePreview.appBuilder : null,
            locale: !kReleaseMode ? DevicePreview.locale(context) : null,
            themeMode: theme.mode,
            theme: theme.light,
            darkTheme: theme.dark,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
