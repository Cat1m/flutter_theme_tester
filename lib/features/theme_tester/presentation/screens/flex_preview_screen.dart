import 'package:flutter/material.dart';

class FlexPreviewScreen extends StatelessWidget {
  const FlexPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('FlexColorScheme Preview')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Swatches nhanh
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _swatch('Primary', cs.primary, cs.onPrimary),
                  _swatch('Secondary', cs.secondary, cs.onSecondary),
                  _swatch('Surface', cs.surface, cs.onSurface),
                  _swatch('Background', cs.surface, cs.onSurface),
                  _swatch('Error', cs.error, cs.onError),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Buttons
          const Text('Buttons', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(onPressed: () {}, child: const Text('Filled')),
              FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
              TextButton(onPressed: () {}, child: const Text('Text')),
            ],
          ),
          const SizedBox(height: 16),

          // Inputs
          const Text('Inputs', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Label',
              hintText: 'Type here...',
            ),
          ),
          const SizedBox(height: 16),

          // Navigation bar
          const Text(
            'NavigationBar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          NavigationBar(
            selectedIndex: 1,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.palette_outlined),
                selectedIcon: Icon(Icons.palette),
                label: 'Theme',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Menus / Segmented
          const Text(
            'Segmented & Menus',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('One')),
              ButtonSegment(value: 1, label: Text('Two')),
              ButtonSegment(value: 2, label: Text('Three')),
            ],
            selected: const {1},
            onSelectionChanged: (_) {},
          ),
          const SizedBox(height: 8),
          MenuAnchor(
            builder: (context, controller, child) => OutlinedButton.icon(
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
              icon: const Icon(Icons.more_horiz),
              label: const Text('Open Menu'),
            ),
            menuChildren: const [
              MenuItemButton(child: Text('Item 1')),
              MenuItemButton(child: Text('Item 2')),
              MenuItemButton(child: Text('Item 3')),
            ],
          ),
          const SizedBox(height: 16),

          // Cards
          const Text('Cards', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Title',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text('Card body to check contrast and elevation.'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('ListTile title'),
                  subtitle: Text('Subtitle contrast check'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Dialog & SnackBar
          const Text(
            'Dialog & SnackBar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: [
              OutlinedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (c) => AlertDialog(
                    title: const Text('Dialog'),
                    content: const Text('Check surface/foreground colors.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(c),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(c),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
              OutlinedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SnackBar sample')),
                ),
                child: const Text('Show SnackBar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _swatch(String label, Color bg, Color fg) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: fg, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
