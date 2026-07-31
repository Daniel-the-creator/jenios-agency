import 'package:flutter/material.dart';

/// A simple singleton [ValueNotifier] that holds the current [ThemeMode].
/// Any widget can listen to this and toggle light/dark mode globally.
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier._() : super(ThemeMode.light);

  static final ThemeNotifier instance = ThemeNotifier._();

  bool get isDark => value == ThemeMode.dark;

  void toggle() {
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
