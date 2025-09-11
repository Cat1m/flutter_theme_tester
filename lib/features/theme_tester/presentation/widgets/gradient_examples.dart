import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';

class GradientExamples extends StatelessWidget {
  const GradientExamples({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).extension<AppDecorationTokens>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gradient Buttons',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: t?.buttonGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              minimumSize: const Size.fromHeight(44),
            ),
            onPressed: () {},
            child: const Text('With Gradient'),
          ),
        ),
        const SizedBox(height: 16),
        Text('Gradient Card', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: t?.cardGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('This card uses gradient from tokens'),
        ),
      ],
    );
  }
}
