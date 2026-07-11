import 'package:flutter/material.dart';

class ScrollService {
  static final ScrollService _instance = ScrollService._internal();
  factory ScrollService() => _instance;
  ScrollService._internal();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey journeyKey = GlobalKey();
  final GlobalKey teamKey = GlobalKey();
  final GlobalKey testimonialsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final ScrollController scrollController = ScrollController();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}
