// lib/features/theme_tester/presentation/screens/demo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/app_button.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/app_card.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/app_scaffold.dart';
// 👇 import extension để đọc token
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/providers/theme_provider.dart';
import 'package:flutter_theme_tester/features/theme_tester/data/models/theme_enums.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Gradient Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _DebugPanel(), // 👈 hàng debug
          const SizedBox(height: 16),

          // Sample background gradient block (nhìn rõ luôn)
          _SampleGradientBox(
            title: 'Background Gradient Sample',
            gradient: context.appTokens?.backgroundGradient,
          ),
          const SizedBox(height: 16),

          const AppCard(child: Text('Card theo config (gradient nếu bật)')),
          const SizedBox(height: 12),

          AppButton.primary(
            onPressed: () {},
            child: const Text('Nút theo config (gradient nếu bật)'),
          ),

          const SizedBox(height: 24),
          const AppCard(
            useGradientIfAvailable: false,
            child: Text('Card này tắt gradient cục bộ'),
          ),
        ],
      ),
    );
  }
}

class _DebugPanel extends StatelessWidget {
  const _DebugPanel();

  @override
  Widget build(BuildContext context) {
    final tokens = context.appTokens;
    final provider = context.watch<ThemeProvider>();
    final ui = provider.ui;

    // Log ra console để chắc chắn
    // (bạn có thể xoá sau khi test)
    // ignore: avoid_print
    print(
      '[DEBUG] tokens? ${tokens != null}'
      ', bg=${tokens?.backgroundGradient != null}'
      ', btn=${tokens?.buttonGradient != null}'
      ', card=${tokens?.cardGradient != null}'
      ', engine=${ui.engine}'
      ', parts=${ui.gradientParts}',
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Engine: ${ui.engine.name.toUpperCase()}'),
              const SizedBox(height: 4),
              Text(
                'Gradient parts: ${ui.gradientParts.map((e) => e.name).join(", ")}',
              ),
              const SizedBox(height: 8),
              Text('Has tokens: ${tokens != null}'),
              Text('backgroundGradient: ${tokens?.backgroundGradient != null}'),
              Text('buttonGradient: ${tokens?.buttonGradient != null}'),
              Text('cardGradient: ${tokens?.cardGradient != null}'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SampleGradientBox extends StatelessWidget {
  final String title;
  final Gradient? gradient;
  const _SampleGradientBox({required this.title, required this.gradient});

  @override
  Widget build(BuildContext context) {
    final box = Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null
            ? Theme.of(context).scaffoldBackgroundColor
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        gradient == null ? 'No gradient' : 'Gradient ON',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        box,
      ],
    );
  }
}
