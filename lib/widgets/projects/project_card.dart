import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/project_model.dart';
import '../../theme/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  // Map of project categories to gradient colors
  static const Map<String, List<Color>> _categoryGradients = {
    'Web App': [Color(0xFF667EEA), Color(0xFF764BA2)],
    'Mobile App': [Color(0xFFF093FB), Color(0xFFF5576C)],
    'Design': [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    'E-Commerce': [Color(0xFF43E97B), Color(0xFF38F9D7)],
  };

  static const Map<String, IconData> _categoryIcons = {
    'Web App': Icons.web_rounded,
    'Mobile App': Icons.phone_iphone_rounded,
    'Design': Icons.design_services_rounded,
    'E-Commerce': Icons.shopping_bag_rounded,
  };

  List<Color> get _gradient =>
      _categoryGradients[widget.project.category] ??
      [AppColors.primary, AppColors.primaryDark];

  IconData get _icon =>
      _categoryIcons[widget.project.category] ?? Icons.code_rounded;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 220,
          transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _gradient,
            ),
            image: widget.project.imageUrl.isNotEmpty
                ? DecorationImage(
                    image: AssetImage(widget.project.imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.6),
                      BlendMode.darken,
                    ),
                  )
                : null,
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: _gradient[0].withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
              ),
              Positioned(
                right: 30,
                bottom: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        widget.project.category,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Icon
                    Icon(_icon, color: Colors.white.withValues(alpha: 0.8), size: 28),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      widget.project.title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Hover overlay
              AnimatedOpacity(
                opacity: _hovered ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.visibility_rounded,
                              color: Color(0xFF374151), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'View Project',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: const Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
