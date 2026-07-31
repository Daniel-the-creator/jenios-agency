import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_colors.dart';
import '../../utils/scroll_service.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  bool _statsVisible = false;
  late List<AnimationController> _counterControllers;
  late List<Animation<int>> _counterAnimations;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  final List<_StatData> _stats = [
    _StatData('10+', 'Projects Completed', 10),
    _StatData('2+', 'Years Experience', 2),
    _StatData('24/7', 'Support', 24),
  ];

  @override
  void initState() {
    super.initState();

    _counterControllers = List.generate(
      _stats.length,
      (i) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200 + i * 200),
      ),
    );

    _counterAnimations = List.generate(
      _stats.length,
      (i) => IntTween(begin: 0, end: _stats[i].target).animate(
        CurvedAnimation(parent: _counterControllers[i], curve: Curves.easeOut),
      ),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    for (final c in _counterControllers) {
      c.dispose();
    }
    _floatController.dispose();
    super.dispose();
  }

  void _startCounters() {
    if (_statsVisible) return;
    _statsVisible = true;
    for (int i = 0; i < _counterControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _counterControllers[i].forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final scrollService = ScrollService();

    final isDark = context.isDark;
    return Container(
      key: scrollService.heroKey,
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.darkBg,
                  const Color(0xFF0F2236),
                  AppColors.darkBg,
                ],
              )
            : AppColors.heroGradient,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24,
          vertical: isWide ? 80 : 48,
        ),
        child: Column(
          children: [
            // Main hero content
            isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildTextContent(scrollService),
                      ),
                      const SizedBox(width: 40),
                      Expanded(flex: 4, child: _buildMascot()),
                    ],
                  )
                : Column(
                    children: [
                      _buildMascot(),
                      const SizedBox(height: 32),
                      _buildTextContent(scrollService),
                    ],
                  ),
            const SizedBox(height: 60),
            // Stats
            VisibilityDetector(
              key: const Key('stats-section'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.3) _startCounters();
              },
              child: _buildStats(isWide),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent(ScrollService scrollService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tag pill
        Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '✦ Digital Agency',
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: -0.2, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 20),
        // Heading
        RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Turning ',
                    style: GoogleFonts.poppins(
                      color: context.textDarkColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 48,
                      height: 1.15,
                    ),
                  ),
                  TextSpan(
                    text: 'Ideas',
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 48,
                      height: 1.15,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: '\nInto Digital\nReality',
                    style: GoogleFonts.poppins(
                      color: context.textDarkColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 48,
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 700.ms, delay: 100.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 20),
        Text(
              'We build powerful, beautiful digital experiences that\ngrow your business. From concept to launch, we\'ve got\nyou covered.',
              style: GoogleFonts.poppins(
                color: context.textLightColor,
                fontSize: 16,
                height: 1.7,
              ),
            )
            .animate()
            .fadeIn(duration: 700.ms, delay: 200.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
        const SizedBox(height: 36),
        // CTA Buttons
        Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _HeroCTAButton(
                  label: 'Start a Project',
                  isPrimary: true,
                  icon: Icons.arrow_forward_rounded,
                  onTap: () =>
                      scrollService.scrollToSection(scrollService.contactKey),
                ),
                _HeroCTAButton(
                  label: 'See Our Work',
                  isPrimary: false,
                  icon: Icons.play_circle_outline_rounded,
                  onTap: () =>
                      scrollService.scrollToSection(scrollService.projectsKey),
                ),
              ],
            )
            .animate()
            .fadeIn(duration: 700.ms, delay: 350.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
      ],
    );
  }

  Widget _buildMascot() {
    return AnimatedBuilder(
          animation: _floatAnimation,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: child,
          ),
          child: Container(
            height: 380,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Decorative circle
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.15),
                        AppColors.primary.withValues(alpha: 0.03),
                      ],
                    ),
                  ),
                ),
                // Mascot image
                Image.asset('assets/images/mascot.png', height: 420),
                // Floating badges
                Positioned(
                  top: 30,
                  right: 20,
                  child: _FloatingBadge(icon: Icons.code, label: 'CODES'),
                ),
                Positioned(
                  bottom: 60,
                  left: 10,
                  child: _FloatingBadge(
                    icon: Icons.design_services,
                    label: 'UI/UX',
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 300.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }

  Widget _buildStats(bool isWide) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isWide
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildStatItems(),
            )
          : Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 24,
              runSpacing: 16,
              children: _buildStatItems(),
            ),
    );
  }

  List<Widget> _buildStatItems() {
    return List.generate(_stats.length, (i) {
      final stat = _stats[i];
      final isLast = stat.suffix == '/7';
      return AnimatedBuilder(
        animation: _counterAnimations[i],
        builder: (_, child) {
          final val = _counterAnimations[i].value;
          return _StatWidget(
            value: isLast ? '24/7' : '$val${stat.suffix}',
            label: stat.label,
          );
        },
      );
    });
  }
}

class _StatData {
  final String display;
  final String label;
  final int target;
  late final String suffix;

  _StatData(this.display, this.label, this.target) {
    if (display.endsWith('+')) {
      suffix = '+';
    } else if (display.contains('/')) {
      suffix = '/7';
    } else {
      suffix = '';
    }
  }
}

class _StatWidget extends StatelessWidget {
  final String value;
  final String label;

  const _StatWidget({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: context.textLightColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HeroCTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final IconData icon;
  final VoidCallback onTap;

  const _HeroCTAButton({
    required this.label,
    required this.isPrimary,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_HeroCTAButton> createState() => _HeroCTAButtonState();
}

class _HeroCTAButtonState extends State<_HeroCTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.primaryGradient : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: widget.isPrimary
                ? null
                : Border.all(color: AppColors.primary, width: 2),
            boxShadow: widget.isPrimary && _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: widget.isPrimary ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                widget.icon,
                size: 18,
                color: widget.isPrimary ? Colors.white : AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FloatingBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: context.textDarkColor,
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(begin: 0, end: -6, duration: 2000.ms, curve: Curves.easeInOut);
  }
}
