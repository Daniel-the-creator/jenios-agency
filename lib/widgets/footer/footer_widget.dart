import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_colors.dart';
import '../../utils/scroll_service.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMedium = MediaQuery.of(context).size.width > 600;

    return Container(
      color: context.isDark ? const Color(0xFF09131D) : AppColors.darkBg,
      padding: EdgeInsets.only(
        left: isWide ? 80 : 28,
        right: isWide ? 80 : 28,
        top: 64,
        bottom: 28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main footer columns
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _BrandColumn()),
                    const SizedBox(width: 40),
                    Expanded(flex: 2, child: _ContactColumn()),
                    const SizedBox(width: 40),
                    Expanded(flex: 2, child: _ServicesColumn()),
                    const SizedBox(width: 40),
                    Expanded(flex: 2, child: _CompanyColumn()),
                  ],
                )
              : isMedium
              ? Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4 - 60,
                      child: _BrandColumn(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4 - 60,
                      child: _ContactColumn(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4 - 60,
                      child: _ServicesColumn(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4 - 60,
                      child: _CompanyColumn(),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BrandColumn(),
                    const SizedBox(height: 32),
                    _ContactColumn(),
                    const SizedBox(height: 32),
                    _ServicesColumn(),
                    const SizedBox(height: 32),
                    _CompanyColumn(),
                  ],
                ),
          const SizedBox(height: 48),
          const Divider(color: Color(0xFF1E3A4A)),
          const SizedBox(height: 20),
          // Bottom bar
          isWide
              ? Row(
                  children: [
                    Text(
                      '© ${DateTime.now().year} Jenios Agency. All rights reserved.',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    _FooterLink('Privacy Policy', () {}),
                    const SizedBox(width: 24),
                    _FooterLink('Terms of Service', () {}),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '© ${DateTime.now().year} Jenios Agency.',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _FooterLink('Privacy Policy', () {}),
                        const SizedBox(width: 16),
                        _FooterLink('Terms of Service', () {}),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _BrandColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          child: Image.asset('assets/images/logo.png', height: 80),
        ),
        const SizedBox(height: 16),
        Text(
          'We build powerful digital experiences that grow your business. Trusted by clients worldwide.',
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 13,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 20),
        // Social icons
        Row(
          children: [
            _SocialIcon(
              icon: Icons.facebook_rounded,
              onTap: () => _launchUrl('https://facebook.com'),
            ),
            const SizedBox(width: 10),
            _SocialIcon(
              icon: Icons.telegram,
              onTap: () => _launchUrl('https://twitter.com'),
            ),
            const SizedBox(width: 10),
            _SocialIcon(
              icon: Icons.business,
              onTap: () => _launchUrl('https://linkedin.com'),
            ),
            const SizedBox(width: 10),
            _SocialIcon(
              icon: Icons.camera_alt_rounded,
              onTap: () => _launchUrl('https://instagram.com'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _FooterColumn(
      title: 'Contact',
      children: [
        _FooterInfo(icon: Icons.location_on_rounded, text: 'Lagos, Nigeria'),
        _FooterInfo(icon: Icons.phone_rounded, text: '+234 812 8928 518'),
        _FooterInfo(icon: Icons.email_rounded, text: 'Jeniousagency@gmail.com'),
      ],
    );
  }
}

class _ServicesColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _FooterColumn(
      title: 'Services',
      children: [
        _FooterLink('Web Development', () {}),
        _FooterLink('Mobile Apps', () {}),
        _FooterLink('UI/UX Design', () {}),
        _FooterLink('Cyber Security', () {}),
        _FooterLink('Media Management', () {}),
      ],
    );
  }
}

class _CompanyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrollService = ScrollService();
    return _FooterColumn(
      title: 'Company',
      children: [
        _FooterLink(
          'About Us',
          () => scrollService.scrollToSection(scrollService.journeyKey),
        ),
        _FooterLink(
          'Portfolio',
          () => scrollService.scrollToSection(scrollService.projectsKey),
        ),
        _FooterLink(
          'Team',
          () => scrollService.scrollToSection(scrollService.teamKey),
        ),
        _FooterLink(
          'Contact',
          () => scrollService.scrollToSection(scrollService.contactKey),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _FooterColumn({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink(this.label, this.onTap);

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            widget.label,
            style: GoogleFonts.poppins(
              color: _hovered
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.55),
              fontSize: 13,
              fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FooterInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
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
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered ? AppColors.primary : const Color(0xFF162436),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 10,
                    ),
                  ]
                : [],
          ),
          child: Icon(widget.icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) launchUrl(uri);
}
