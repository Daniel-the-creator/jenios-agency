import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_colors.dart';
import '../../utils/scroll_service.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _visible = false;

  static const List<_ServiceData> _services = [
    _ServiceData(
      icon: Icons.code_rounded,
      title: 'Web Development',
      description:
          'We craft fast, scalable, and beautiful websites and web apps tailored to your business needs — from landing pages to full-stack platforms.',
      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
      tags: ['React', 'Next.js', 'Flutter Web', 'Node.js'],
    ),
    _ServiceData(
      icon: Icons.phone_iphone_rounded,
      title: 'Mobile Apps',
      description:
          'Cross-platform mobile applications built with Flutter that feel native on both iOS and Android, with silky-smooth UX and top-tier performance.',
      gradientColors: [Color(0xFFF093FB), Color(0xFFF5576C)],
      tags: ['Flutter', 'iOS', 'Android', 'Firebase'],
    ),
    _ServiceData(
      icon: Icons.design_services_rounded,
      title: 'UI/UX Design',
      description:
          'Award-worthy interfaces that are as intuitive as they are beautiful. We combine user research, prototyping, and modern design systems.',
      gradientColors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
      tags: ['Figma', 'Prototyping', 'Design Systems', 'User Research'],
    ),
    _ServiceData(
      icon: Icons.security_rounded,
      title: 'Cyber Security',
      description:
          'Protect your digital assets with comprehensive security assessments, penetration testing, and tailored defence strategies.',
      gradientColors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
      tags: ['Pen Testing', 'SIEM', 'ISO 27001', 'Audits'],
    ),
    _ServiceData(
      icon: Icons.camera_alt_rounded,
      title: 'Media Management',
      description:
          'From brand photography to cinematic video production, we create compelling visual content that tells your story and grows your audience.',
      gradientColors: [Color(0xFFFDA085), Color(0xFFF6D365)],
      tags: ['Photography', 'Video', 'Social Media', 'Brand Content'],
    ),
    _ServiceData(
      icon: Icons.bar_chart_rounded,
      title: 'Digital Strategy',
      description:
          'We partner with you to create comprehensive digital roadmaps — aligning technology, design, and business goals for measurable results.',
      gradientColors: [Color(0xFF00C9A7), Color(0xFF00A88A)],
      tags: ['Strategy', 'Analytics', 'Growth', 'Consulting'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMedium = MediaQuery.of(context).size.width > 600;
    final scrollService = ScrollService();

    return VisibilityDetector(
      key: const Key('services-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: scrollService.servicesKey,
        color: context.surfaceColor,
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTag(label: 'What We Do'),
                const SizedBox(height: 12),
                Text(
                  'Our Services',
                  style: GoogleFonts.poppins(
                    fontSize: isWide ? 36 : 28,
                    fontWeight: FontWeight.w800,
                    color: context.textDarkColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'End-to-end digital solutions to help your business thrive.',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: context.textLightColor,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.1, end: 0),
            const SizedBox(height: 48),
            // Services grid
            isWide
                ? _buildWideGrid()
                : isMedium
                    ? _buildMediumGrid()
                    : _buildNarrowList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWideGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.05,
      ),
      itemCount: _services.length,
      itemBuilder: (_, i) => _ServiceCard(
        service: _services[i],
        index: i,
        visible: _visible,
      ),
    );
  }

  Widget _buildMediumGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.0,
      ),
      itemCount: _services.length,
      itemBuilder: (_, i) => _ServiceCard(
        service: _services[i],
        index: i,
        visible: _visible,
      ),
    );
  }

  Widget _buildNarrowList() {
    return Column(
      children: _services.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _ServiceCard(service: e.value, index: e.key, visible: _visible),
        );
      }).toList(),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _ServiceData service;
  final int index;
  final bool visible;

  const _ServiceCard({
    required this.service,
    required this.index,
    required this.visible,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? widget.service.gradientColors[0].withValues(alpha: 0.4)
                : context.borderColor,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.service.gradientColors[0].withValues(alpha: 0.15),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.service.gradientColors,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: widget.service.gradientColors[0].withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Icon(widget.service.icon, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 18),
            // Title
            Text(
              widget.service.title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: context.textDarkColor,
              ),
            ),
            const SizedBox(height: 8),
            // Description
            Expanded(
              child: Text(
                widget.service.description,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: context.textLightColor,
                  height: 1.65,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(height: 14),
            // Tags
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.service.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.service.gradientColors[0].withValues(alpha: 0.12),
                        widget.service.gradientColors[1].withValues(alpha: 0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: widget.service.gradientColors[0],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    )
        .animate(target: widget.visible ? 1 : 0)
        .fadeIn(delay: Duration(milliseconds: widget.index * 100))
        .slideY(begin: 0.1, end: 0);
  }
}

class _ServiceData {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradientColors;
  final List<String> tags;

  const _ServiceData({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradientColors,
    required this.tags,
  });
}

class _SectionTag extends StatelessWidget {
  final String label;
  const _SectionTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: context.tagBgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
