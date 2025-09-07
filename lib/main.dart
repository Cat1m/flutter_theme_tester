import 'package:flutter/widgets.dart';
import 'features/theme_tester/presentation/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomeAppSeed());
}

/// App seed rất mỏng để Step 1 chạy ngay.
class HomeAppSeed extends StatelessWidget {
  const HomeAppSeed({super.key});

  @override
  Widget build(BuildContext context) => const HomeScreen();
}
