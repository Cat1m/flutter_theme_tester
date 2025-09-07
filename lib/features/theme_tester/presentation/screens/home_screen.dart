import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/theme_store.dart';
import '../providers/color_input_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/color_input/four_color_input_form.dart';
import '../widgets/theme_selector/theme_mode_toggle.dart';
import 'theme_preview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(ThemeStore())..init(),
        ),
        ChangeNotifierProvider(create: (_) => ColorInputProvider()),
      ],
      child: const _HomeScaffold(),
    );
  }
}

class _HomeScaffold extends StatelessWidget {
  const _HomeScaffold();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>().appTheme;

    return MaterialApp(
      title: 'Flutter Theme Tester',
      debugShowCheckedModeBanner: false,
      themeMode: theme.mode,
      theme: theme.light,
      darkTheme: theme.dark,
      home: Scaffold(
        appBar: AppBar(title: const Text('Theme Tester (Lite)')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ThemeModeToggle(),
              const SizedBox(height: 16),
              const FourColorInputForm(),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ThemePreviewScreen(),
                    ),
                  ),
                  child: const Text('Xem Preview'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
