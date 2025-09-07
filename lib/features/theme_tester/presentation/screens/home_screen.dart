import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/theme_selector/predefined_theme_grid.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ThemeModeToggle(),
                const SizedBox(height: 16),
                const FourColorInputForm(),
                const SizedBox(height: 16),
                const Text(
                  'Predefined Themes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Grid đã shrinkWrap + không cuộn, để parent cuộn
                const PredefinedThemeGrid(),
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
      ),
    );
  }
}
