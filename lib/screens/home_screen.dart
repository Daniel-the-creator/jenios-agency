import 'package:flutter/material.dart';
import '../utils/scroll_service.dart';
import '../widgets/navbar/navbar_widget.dart';
import '../widgets/hero/hero_section.dart';
import '../widgets/services/services_section.dart';
import '../widgets/projects/projects_section.dart';
import '../widgets/journey/journey_section.dart';
import '../widgets/team/team_section.dart';
import '../widgets/cta/cta_banner.dart';
import '../widgets/footer/footer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollService _scrollService = ScrollService();

  @override
  void dispose() {
    _scrollService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollService.scrollController,
            child: Column(
              children: const [
                // Navbar placeholder height
                SizedBox(height: 72),
                HeroSection(),
                ServicesSection(),
                ProjectsSection(),
                JourneySection(),
                TeamSection(),
                CtaBanner(),
                FooterWidget(),
              ],
            ),
          ),
          // Sticky Navbar overlaid at top
          Positioned(top: 0, left: 0, right: 0, child: const NavbarWidget()),
        ],
      ),
    );
  }
}
