import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JeniosApp());
}

class JeniosApp extends StatelessWidget {
  const JeniosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jenios Agency — Digital Solutions',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
