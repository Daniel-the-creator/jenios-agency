import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JeniosApp());
}

class JeniosApp extends StatelessWidget {
  const JeniosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.instance,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Jenios Agency — Digital Solutions',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
