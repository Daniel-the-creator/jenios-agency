import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_notifier.dart';
import '../../utils/scroll_service.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  bool _isScrolled = false;
  bool _mobileMenuOpen = false;
  final ScrollService _scrollService = ScrollService();

  final List<_NavItem> _navItems = [
    _NavItem('Home', 'hero'),
    _NavItem('Services', 'services'),
    _NavItem('Portfolio', 'projects'),
    _NavItem('About', 'journey'),
    _NavItem('Team', 'team'),
    _NavItem('Contact', 'contact'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollService.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollService.scrollController.offset > 20;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  void dispose() {
    _scrollService.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _navigateTo(String section) {
    setState(() => _mobileMenuOpen = false);
    final keyMap = {
      'hero': _scrollService.heroKey,
      'services': _scrollService.servicesKey,
      'projects': _scrollService.projectsKey,
      'journey': _scrollService.journeyKey,
      'team': _scrollService.teamKey,
      'testimonials': _scrollService.testimonialsKey,
      'contact': _scrollService.contactKey,
    };
    final key = keyMap[section];
    if (key != null) _scrollService.scrollToSection(key);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = isDark ? const Color(0xFF0D1B2A) : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _isScrolled
            ? navBg.withValues(alpha: 0.97)
            : navBg.withValues(alpha: 0.85),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 24,
                vertical: 14,
              ),
              child: Row(
                children: [
                  // Logo
                  _buildLogo(),
                  const Spacer(),
                  if (isWide) ...[
                    // Nav links
                    ..._navItems.map(
                      (item) => _NavLink(
                        label: item.label,
                        onTap: () => _navigateTo(item.section),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const _ThemeToggleButton(),
                    const SizedBox(width: 16),
                    _GetInTouchButton(onTap: () => _navigateTo('contact')),
                  ] else ...[
                    const _ThemeToggleButton(),
                    IconButton(
                      onPressed: () =>
                          setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _mobileMenuOpen ? Icons.close : Icons.menu,
                          key: ValueKey(_mobileMenuOpen),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Mobile dropdown
            if (!isWide && _mobileMenuOpen)
              _MobileMenu(items: _navItems, onNavigate: _navigateTo),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset('assets/images/logo.png', height: 100);
  }
}

class _NavItem {
  final String label;
  final String section;
  const _NavItem(this.label, this.section);
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? AppColors.primary : AppColors.textMedium,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _hovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GetInTouchButton extends StatefulWidget {
  final VoidCallback onTap;
  const _GetInTouchButton({required this.onTap});

  @override
  State<_GetInTouchButton> createState() => _GetInTouchButtonState();
}

class _GetInTouchButtonState extends State<_GetInTouchButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            'Get In Touch',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final List<_NavItem> items;
  final void Function(String) onNavigate;

  const _MobileMenu({required this.items, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF0D1B2A) : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...items.map(
            (item) => InkWell(
              onTap: () => onNavigate(item.section),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  item.label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : AppColors.textDark,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => onNavigate('contact'),
              child: const Text('Get In Touch'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// Animated sun/moon toggle button that switches between light and dark mode.
class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.instance,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        return Tooltip(
          message: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: ThemeNotifier.instance.toggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                width: 52,
                height: 28,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isDark
                      ? AppColors.primary.withValues(alpha: 0.85)
                      : const Color(0xFFE5E7EB),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Track icons
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Icon(
                          Icons.wb_sunny_rounded,
                          size: 14,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.4)
                              : const Color(0xFFFBBF24),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.nightlight_round,
                          size: 13,
                          color: isDark
                              ? Colors.white
                              : Colors.grey.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    // Sliding thumb
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      alignment: isDark
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
