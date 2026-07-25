import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../data/mock_data.dart';
import '../../models/testimonial_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/scroll_service.dart';

class JourneySection extends StatefulWidget {
  const JourneySection({super.key});

  @override
  State<JourneySection> createState() => _JourneySectionState();
}

class _JourneySectionState extends State<JourneySection>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _lineController;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _lineAnimation = CurvedAnimation(
      parent: _lineController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  void _onVisible() {
    if (_visible) return;
    if (mounted) {
      setState(() => _visible = true);
      _lineController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final milestones = MockData.journeyMilestones;
    final isWide = MediaQuery.of(context).size.width > 900;
    final scrollService = ScrollService();

    return VisibilityDetector(
      key: const Key('journey-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05) _onVisible();
      },
      child: Container(
        key: scrollService.journeyKey,
        color: AppColors.surface,
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
                _SectionTag(label: 'Our Story'),
                const SizedBox(height: 12),
                Text(
                  'Our Journey',
                  style: GoogleFonts.poppins(
                    fontSize: isWide ? 36 : 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'From a bold vision to a growing agency — here\'s how we got here.',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.1, end: 0),
            const SizedBox(height: 60),
            // Timeline
            isWide
                ? _HorizontalTimeline(
                    milestones: milestones,
                    lineAnimation: _lineAnimation,
                    visible: _visible,
                  )
                : _VerticalTimeline(
                    milestones: milestones,
                    visible: _visible,
                  ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalTimeline extends StatelessWidget {
  final List<JourneyMilestone> milestones;
  final Animation<double> lineAnimation;
  final bool visible;

  const _HorizontalTimeline({
    required this.milestones,
    required this.lineAnimation,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated line
        Positioned(
          left: 0,
          right: 0,
          top: 18,
          child: AnimatedBuilder(
            animation: lineAnimation,
            builder: (_, child) => FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: lineAnimation.value,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        // Milestones
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: milestones.asMap().entries.map((entry) {
            final i = entry.key;
            final milestone = entry.value;
            return Expanded(
              child: _MilestoneCard(
                milestone: milestone,
                index: i,
                isLast: i == milestones.length - 1,
                visible: visible,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _VerticalTimeline extends StatelessWidget {
  final List<JourneyMilestone> milestones;
  final bool visible;

  const _VerticalTimeline({required this.milestones, required this.visible});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: milestones.asMap().entries.map((entry) {
        final i = entry.key;
        final m = entry.value;
        final delay = Duration(milliseconds: i * 150);

        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: AnimatedSlide(
            offset: visible ? Offset.zero : const Offset(-0.05, 0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: _buildVerticalItem(i, m, delay),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVerticalItem(int i, JourneyMilestone m, Duration delay) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Line + dot
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            if (i < milestones.length - 1)
              Container(
                width: 2,
                height: 80,
                color: AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  m.year,
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  m.title,
                  style: GoogleFonts.poppins(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  m.description,
                  style: GoogleFonts.poppins(
                    color: AppColors.textLight,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MilestoneCard extends StatefulWidget {
  final JourneyMilestone milestone;
  final int index;
  final bool isLast;
  final bool visible;

  const _MilestoneCard({
    required this.milestone,
    required this.index,
    required this.isLast,
    required this.visible,
  });

  @override
  State<_MilestoneCard> createState() => _MilestoneCardState();
}

class _MilestoneCardState extends State<_MilestoneCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500 + widget.index * 100),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: widget.visible ? Offset.zero : const Offset(0, 0.08),
        duration: Duration(milliseconds: 500 + widget.index * 100),
        curve: Curves.easeOut,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: Padding(
            padding: EdgeInsets.only(right: widget.isLast ? 0 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dot
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index + 1}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Card
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _hovered ? AppColors.primaryLight : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : AppColors.border,
                    ),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.milestone.year,
                        style: GoogleFonts.poppins(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.milestone.title,
                        style: GoogleFonts.poppins(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.milestone.description,
                        style: GoogleFonts.poppins(
                          color: AppColors.textLight,
                          fontSize: 12.5,
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTag extends StatelessWidget {
  final String label;
  const _SectionTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
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
