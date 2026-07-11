import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/project_model.dart';
import '../../utils/scroll_service.dart';
import 'project_card.dart';
import 'project_detail_dialog.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = MockData.projects;
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMedium = MediaQuery.of(context).size.width > 600;
    final scrollService = ScrollService();

    return Container(
      key: scrollService.projectsKey,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTag(label: 'Our Work'),
                    const SizedBox(height: 12),
                    Text(
                      'Our Projects',
                      style: GoogleFonts.poppins(
                        fontSize: isWide ? 36 : 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Transformative digital solutions we\'ve crafted for our clients.',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              if (isWide) _ShowAllButton(),
            ],
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
          const SizedBox(height: 40),
          // Project grid
          isWide
              ? _buildWideGrid(projects, context)
              : isMedium
                  ? _buildMediumGrid(projects, context)
                  : _buildNarrowList(projects, context),
          if (!isWide) ...[
            const SizedBox(height: 28),
            Center(child: _ShowAllButton()),
          ],
        ],
      ),
    );
  }

  Widget _buildWideGrid(List<ProjectModel> projects, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ProjectCard(
                project: projects[0],
                onTap: () => _showDetail(context, projects[0]),
              ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideX(begin: -0.05, end: 0),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: ProjectCard(
                project: projects[1],
                onTap: () => _showDetail(context, projects[1]),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.05, end: 0),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ProjectCard(
                project: projects[2],
                onTap: () => _showDetail(context, projects[2]),
              ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideY(begin: 0.05, end: 0),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: ProjectCard(
                project: projects[3],
                onTap: () => _showDetail(context, projects[3]),
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: 0.05, end: 0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMediumGrid(List<ProjectModel> projects, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
      ),
      itemCount: projects.length,
      itemBuilder: (_, i) => ProjectCard(
        project: projects[i],
        onTap: () => _showDetail(context, projects[i]),
      ).animate().fadeIn(duration: 500.ms, delay: (i * 100).ms),
    );
  }

  Widget _buildNarrowList(List<ProjectModel> projects, BuildContext context) {
    return Column(
      children: projects
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ProjectCard(
                  project: p,
                  onTap: () => _showDetail(context, p),
                ).animate().fadeIn(duration: 500.ms),
              ))
          .toList(),
    );
  }

  void _showDetail(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      builder: (_) => ProjectDetailDialog(project: project),
    );
  }
}

class _ShowAllButton extends StatefulWidget {
  @override
  State<_ShowAllButton> createState() => _ShowAllButtonState();
}

class _ShowAllButtonState extends State<_ShowAllButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary : AppColors.primaryLight,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Show All',
                style: GoogleFonts.poppins(
                  color: _hovered ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _hovered ? Colors.white : AppColors.primary,
              ),
            ],
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
