import 'package:flutter/material.dart';

class CompareThemePage extends StatelessWidget {
  final ThemeData themeFlex;
  final ThemeData themeVanilla;
  const CompareThemePage({
    super.key,
    required this.themeFlex,
    required this.themeVanilla,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Theme(
            data: themeFlex,
            child: const _DemoPanel(title: 'Flex engine'),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: Theme(
            data: themeVanilla,
            child: const _DemoPanel(title: 'Vanilla engine'),
          ),
        ),
      ],
    );
  }
}

class _DemoPanel extends StatelessWidget {
  final String title;
  const _DemoPanel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(onPressed: null, child: Text('Disabled')),
              FilledButton(onPressed: null, child: Text('Primary')),
            ],
          ),
          SizedBox(height: 12),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('This is a Card – uses shared components overrides.'),
            ),
          ),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Input demo')),
        ],
      ),
    );
  }
}
