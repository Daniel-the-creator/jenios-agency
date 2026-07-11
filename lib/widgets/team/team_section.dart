import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../data/mock_data.dart';
import '../../models/team_member_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/scroll_service.dart';

class TeamSection extends StatefulWidget {
  const TeamSection({super.key});

  @override
  State<TeamSection> createState() => _TeamSectionState();
}

class _TeamSectionState extends State<TeamSection> {
  int _hoveredIndex = -1;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final members = MockData.teamMembers;
    final isWide = MediaQuery.of(context).size.width > 900;
    final scrollService = ScrollService();

    return VisibilityDetector(
      key: const Key('team-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        key: scrollService.teamKey,
        color: AppColors.background,
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
                _SectionTag(label: 'The Team'),
                const SizedBox(height: 12),
                Text(
                  'Our Team Members',
                  style: GoogleFonts.poppins(
                    fontSize: isWide ? 36 : 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Talented professionals dedicated to your success.',
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
            const SizedBox(height: 48),
            // Team layout
            isWide
                ? _buildDesktopLayout(members)
                : _buildMobileLayout(members),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(List<TeamMemberModel> members) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Names & Avatars
        Expanded(
          flex: 4,
          child: Column(
            children: members.asMap().entries.map((entry) {
              final i = entry.key;
              final member = entry.value;
              final isHovered = _hoveredIndex == i;
              return MouseRegion(
                onEnter: (_) => setState(() => _hoveredIndex = i),
                onExit: (_) => setState(() => _hoveredIndex = -1),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _showMemberProfile(member),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isHovered ? AppColors.primaryLight : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _AvatarWidget(member: member, isHovered: isHovered),
                        const SizedBox(width: 14),
                        Text(
                          member.name,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight:
                                isHovered ? FontWeight.w700 : FontWeight.w500,
                            color: isHovered
                                ? AppColors.textDark
                                : AppColors.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .animate(target: _visible ? 1 : 0)
                  .fadeIn(delay: Duration(milliseconds: i * 100))
                  .slideX(begin: -0.05, end: 0);
            }).toList(),
          ),
        ),
        const SizedBox(width: 60),
        // Right: Roles
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: members.asMap().entries.map((entry) {
              final i = entry.key;
              final member = entry.value;
              final isHovered = _hoveredIndex == i;
              return GestureDetector(
                onTap: () => _showMemberProfile(member),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isHovered
                        ? AppColors.primary
                        : AppColors.textDark.withValues(alpha: 0.15),
                    letterSpacing: -0.5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(member.role),
                  ),
                ),
              )
                  .animate(target: _visible ? 1 : 0)
                  .fadeIn(delay: Duration(milliseconds: 100 + i * 100))
                  .slideX(begin: 0.05, end: 0);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(List<TeamMemberModel> members) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: members.length,
      itemBuilder: (_, i) {
        final member = members[i];
        return GestureDetector(
          onTap: () => _showMemberProfile(member),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AvatarWidget(member: member, isHovered: false, size: 60),
                const SizedBox(height: 12),
                Text(
                  member.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member.role,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms, delay: (i * 80).ms),
        );
      },
    );
  }

  void _showMemberProfile(TeamMemberModel member) {
    showDialog(
      context: context,
      builder: (_) => _MemberProfileDialog(member: member),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  final TeamMemberModel member;
  final bool isHovered;
  final double size;

  const _AvatarWidget({
    required this.member,
    required this.isHovered,
    this.size = 44,
  });

  Color get _avatarColor {
    final colors = [
      const Color(0xFF667EEA),
      const Color(0xFFF5576C),
      const Color(0xFF43E97B),
      const Color(0xFFFA709A),
      const Color(0xFF00C9A7),
    ];
    return colors[member.id.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _avatarColor,
        image: member.avatarUrl.isNotEmpty
            ? DecorationImage(
                image: AssetImage(member.avatarUrl),
                fit: BoxFit.cover,
              )
            : null,
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: _avatarColor.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      child: member.avatarUrl.isEmpty
          ? Center(
              child: Text(
                member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.38,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          : null,
    );
  }
}

class _MemberProfileDialog extends StatelessWidget {
  final TeamMemberModel member;

  const _MemberProfileDialog({required this.member});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isWide ? 120 : 24,
        vertical: 60,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 12),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                      image: member.avatarUrl.isNotEmpty
                          ? DecorationImage(
                              image: AssetImage(member.avatarUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: member.avatarUrl.isEmpty
                        ? Center(
                            child: Text(
                              member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          member.role,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded,
                        color: Colors.white, size: 22),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        member.bio,
                        style: GoogleFonts.poppins(
                          color: AppColors.textLight,
                          fontSize: 13,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Skills',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: member.skills
                            .map((s) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    s,
                                    style: GoogleFonts.poppins(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      if (member.linkedInUrl != null) ...[
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse(member.linkedInUrl!);
                              if (await canLaunchUrl(uri)) launchUrl(uri);
                            },
                            icon: const Icon(Icons.link_rounded, size: 18),
                            label: const Text('View LinkedIn'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
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
