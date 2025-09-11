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
        children: [
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(onPressed: null, child: Text('Disabled')),
              FilledButton(onPressed: null, child: Text('Primary')),
            ],
          ),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('This is a Card – uses shared components overrides.'),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Input demo')),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),

          // SegmentedButton demo
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(
                value: 1,
                label: Text('One'),
                icon: Icon(Icons.looks_one),
              ),
              ButtonSegment(
                value: 2,
                label: Text('Two'),
                icon: Icon(Icons.looks_two),
              ),
              ButtonSegment(
                value: 3,
                label: Text('Three'),
                icon: Icon(Icons.looks_3),
              ),
            ],
            selected: const {2},
            onSelectionChanged: (_) {},
          ),

          const SizedBox(height: 12),

          // NavigationBar demo
          NavigationBar(
            selectedIndex: 1,
            onDestinationSelected: (_) {},
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'Fav',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Toggles demo
          const Row(
            children: const [
              Switch(value: true, onChanged: null),
              SizedBox(width: 8),
              Checkbox(value: true, onChanged: null),
              SizedBox(width: 8),
              Radio(value: 1, groupValue: 1, onChanged: null),
            ],
          ),

          const SizedBox(height: 12),

          // Slider/Progress demo
          Slider(value: 0.6, onChanged: (_) {}),
          const LinearProgressIndicator(value: 0.6),
          const SizedBox(height: 8),
          const CircularProgressIndicator(),

          const SizedBox(height: 12),

          // Tooltip/Snack demo triggers
          Wrap(
            spacing: 8,
            children: [
              const Tooltip(
                message: 'I\'m a tooltip',
                child: const Icon(Icons.info_outline),
              ),
              ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Hello SnackBar'))),
                child: const Text('Show Snack'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
