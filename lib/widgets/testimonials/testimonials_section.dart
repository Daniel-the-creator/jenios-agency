import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/mock_data.dart';
import '../../models/testimonial_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/scroll_service.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isHovered = false;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_isHovered && mounted) {
        final testimonials = MockData.testimonials;
        final next = (_currentPage + 1) % testimonials.length;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final testimonials = MockData.testimonials;
    final isWide = MediaQuery.of(context).size.width > 900;
    final scrollService = ScrollService();

    return Container(
      key: scrollService.testimonialsKey,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _SectionTag(label: 'Reviews'),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Tell us about your Inspiration',
                style: GoogleFonts.poppins(
                  fontSize: isWide ? 36 : 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'What our clients say about working with us.',
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
          const SizedBox(height: 16),
          // Avatar row
          _AvatarRow(testimonials: testimonials, currentPage: _currentPage),
          const SizedBox(height: 36),
          // Testimonial cards
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: SizedBox(
              height: isWide ? 220 : 280,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: testimonials.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _TestimonialCard(testimonial: testimonials[i]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Controls row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ArrowButton(
                icon: Icons.chevron_left_rounded,
                onTap: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              const SizedBox(width: 16),
              SmoothPageIndicator(
                controller: _pageController,
                count: testimonials.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.border,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                ),
              ),
              const SizedBox(width: 16),
              _ArrowButton(
                icon: Icons.chevron_right_rounded,
                onTap: () {
                  if (_currentPage < testimonials.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarRow extends StatelessWidget {
  final List<TestimonialModel> testimonials;
  final int currentPage;

  const _AvatarRow({required this.testimonials, required this.currentPage});

  Color _avatarColor(int i) {
    final colors = [
      const Color(0xFF667EEA),
      const Color(0xFFF5576C),
      const Color(0xFF43E97B),
      const Color(0xFFFBBF24),
    ];
    return colors[i % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: testimonials.asMap().entries.map((entry) {
        final i = entry.key;
        final t = entry.value;
        final isActive = i == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 46 : 38,
          height: isActive ? 46 : 38,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _avatarColor(i),
            border: isActive
                ? Border.all(color: AppColors.primary, width: 2.5)
                : null,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              t.name[0].toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: isActive ? 18 : 15,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final TestimonialModel testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    testimonial.position,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _StarRating(rating: testimonial.rating),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              '"${testimonial.review}"',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textMedium,
                height: 1.7,
                fontStyle: FontStyle.italic,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final double rating;
  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating.floor();
        final half = !filled && i < rating;
        return Icon(
          filled
              ? Icons.star_rounded
              : half
                  ? Icons.star_half_rounded
                  : Icons.star_border_rounded,
          color: AppColors.starYellow,
          size: 18,
        );
      }),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
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
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered ? AppColors.primary : Colors.white,
            border: Border.all(color: AppColors.border),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                    )
                  ]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: _hovered ? Colors.white : AppColors.textMedium,
            size: 22,
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
