// lib/features/theme_tester/presentation/screens/demo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/app_button.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/app_card.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/app_scaffold.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/widgets/gradient_examples.dart';
// 👇 import extension để đọc token
import 'package:flutter_theme_tester/features/theme_tester/themes/app_decoration_tokens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_theme_tester/features/theme_tester/presentation/providers/theme_provider.dart';

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
                children: [
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
                    child: Icon(Icons.info_outline),
                  ),
                  ElevatedButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hello SnackBar')),
                    ),
                    child: const Text('Show Snack'),
                  ),
                ],
              ),
              const GradientExamples(),
              // Drawer demo
              Builder(
                builder: (ctx) => Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                      child: const Text('Open Drawer'),
                    ),
                  ],
                ),
              ),

              // Dialog demo
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Dialog title'),
                    content: const Text('This is a styled dialog'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Show Dialog'),
              ),

              // DatePicker demo
              ElevatedButton(
                onPressed: () async {
                  await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                },
                child: const Text('Show DatePicker'),
              ),

              // TimePicker demo
              ElevatedButton(
                onPressed: () async {
                  await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: const Text('Show TimePicker'),
              ),

              // Badge demo
              Badge(
                label: const Text('5'),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
              ),

              // ListTile density demo
              const Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Item A'),
                      leading: Icon(Icons.label_outline),
                    ),
                    ListTile(
                      selected: true,
                      title: Text('Item B (selected)'),
                      leading: Icon(Icons.label),
                    ),
                    ListTile(
                      title: Text('Item C'),
                      leading: Icon(Icons.label_outline),
                    ),
                  ],
                ),
              ),

              // SearchBar
              const SizedBox(height: 12),
              const SearchBar(
                hintText: 'Search anything...',
                leading: Icon(Icons.search),
                trailing: [Icon(Icons.mic_none)],
              ),

              // DropdownMenu
              const SizedBox(height: 12),
              const DropdownMenu<String>(
                width: 220,
                hintText: 'Select item',
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'a', label: 'Alpha'),
                  DropdownMenuEntry(value: 'b', label: 'Beta'),
                  DropdownMenuEntry(value: 'c', label: 'Gamma'),
                ],
              ),

              // MenuAnchor (context menu)
              const SizedBox(height: 12),
              MenuAnchor(
                builder: (ctx, controller, child) => FilledButton.icon(
                  icon: const Icon(Icons.more_vert),
                  label: const Text('Open menu'),
                  onPressed: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                ),
                menuChildren: const [
                  MenuItemButton(
                    leadingIcon: Icon(Icons.copy),
                    child: Text('Copy'),
                  ),
                  MenuItemButton(
                    leadingIcon: Icon(Icons.share),
                    child: Text('Share'),
                  ),
                ],
              ),

              // PopupMenuButton
              const SizedBox(height: 12),
              PopupMenuButton<int>(
                itemBuilder: (ctx) => const [
                  PopupMenuItem(value: 1, child: Text('Item 1')),
                  PopupMenuItem(value: 2, child: Text('Item 2')),
                ],
                child: Icon(Icons.adaptive.more),
              ),

              // FAB + BottomSheet
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (_) => const SizedBox(
                    height: 200,
                    child: Center(child: Text('Sheet content')),
                  ),
                ),
                child: const Text('Show BottomSheet'),
              ),
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
