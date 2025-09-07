import 'package:flutter/material.dart';

class ThemePreviewScreen extends StatelessWidget {
  const ThemePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Components')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Typography Headline',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Body sample text to check contrast and readability.'),
          SizedBox(height: 16),
          _ButtonsDemo(),
          SizedBox(height: 16),
          _InputsDemo(),
        ],
      ),
    );
  }
}

class _ButtonsDemo extends StatelessWidget {
  const _ButtonsDemo();
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FilledButton(onPressed: null, child: Text('Filled')),
        FilledButton.tonal(onPressed: null, child: Text('Tonal')),
        OutlinedButton(onPressed: null, child: Text('Outlined')),
        TextButton(onPressed: null, child: Text('Text')),
      ],
    );
  }
}

class _InputsDemo extends StatelessWidget {
  const _InputsDemo();
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Input label',
        hintText: 'Type here...',
      ),
    );
  }
}
