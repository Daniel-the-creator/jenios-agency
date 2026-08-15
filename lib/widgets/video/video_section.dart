import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../theme/app_theme.dart';
import '../../theme/theme_colors.dart';

class VideoSection extends StatefulWidget {
  /// Path to the local video asset, e.g. 'assets/videos/showcase.mp4'
  final String assetPath;

  const VideoSection({
    super.key,
    this.assetPath = 'assets/videos/showcase.mp4',
  });

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isMuted = true;
  bool _isPlaying = false;
  bool _showControls = true;

  late AnimationController _overlayController;
  late Animation<double> _overlayAnimation;

  @override
  void initState() {
    super.initState();

    _overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0,
    );
    _overlayAnimation = CurvedAnimation(
      parent: _overlayController,
      curve: Curves.easeOut,
    );

    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() => _initialized = true);
              _controller.setLooping(true);
              _controller.setVolume(0); // start muted for autoplay compliance
            }
          })
          .catchError((e) {
            // Video file not yet added — silently handled
            debugPrint('VideoSection: Could not load video: $e');
          });

    _controller.addListener(_onVideoUpdate);
  }

  void _onVideoUpdate() {
    if (mounted) setState(() => _isPlaying = _controller.value.isPlaying);
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_initialized) return;
    if (info.visibleFraction > 0.25) {
      if (!_controller.value.isPlaying) {
        _controller.play();
        _scheduleHideControls();
      }
    } else {
      if (_controller.value.isPlaying) _controller.pause();
    }
  }

  void _togglePlayPause() {
    if (!_initialized) return;
    if (_controller.value.isPlaying) {
      _controller.pause();
      _overlayController.animateTo(1.0);
      setState(() => _showControls = true);
    } else {
      _controller.play();
      _scheduleHideControls();
    }
  }

  void _toggleMute() {
    if (!_initialized) return;
    setState(() => _isMuted = !_isMuted);
    _controller.setVolume(_isMuted ? 0 : 1);
  }

  void _scheduleHideControls() {
    _overlayController.animateTo(0.0);
    setState(() => _showControls = false);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _controller.value.isPlaying) {
        _overlayController.animateTo(0.0);
        setState(() => _showControls = false);
      }
    });
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _overlayController.animateTo(1.0);
      setState(() => _showControls = true);
    } else if (_controller.value.isPlaying) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted && _controller.value.isPlaying) {
          _overlayController.animateTo(0.0);
          setState(() => _showControls = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoUpdate);
    _controller.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isDark = context.isDark;

    return VisibilityDetector(
      key: const Key('video-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24,
          vertical: isWide ? 80 : 60,
        ),
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkBg,
                    const Color(0xFF0A1628),
                    AppColors.darkBg,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF8FAFF),
                    const Color(0xFFEFF4FF),
                    const Color(0xFFF8FAFF),
                  ],
                ),
        ),
        child: Column(
          children: [
            // ── Section Header ──────────────────────────────────────────
            _buildSectionHeader(isDark)
                .animate()
                .fadeIn(duration: 700.ms)
                .slideY(begin: 0.15, end: 0, curve: Curves.easeOut),

            const SizedBox(height: 48),

            // ── Video Player ─────────────────────────────────────────────
            _buildVideoPlayer(isWide, isDark)
                .animate()
                .fadeIn(duration: 800.ms, delay: 200.ms)
                .scale(
                  begin: const Offset(0.96, 0.96),
                  end: const Offset(1, 1),
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return Column(
      children: [
        // Label pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            '▶  Details about what we do',
            style: GoogleFonts.poppins(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'See Us In Action',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF0D1B2A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A glimpse into the services we offer',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: isDark
                ? Colors.white.withValues(alpha: 0.6)
                : const Color(0xFF6B7280),
            height: 1.7,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer(bool isWide, bool isDark) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: Container(
        constraints: BoxConstraints(maxWidth: isWide ? 900 : double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.15),
              blurRadius: 60,
              offset: const Offset(0, 20),
              spreadRadius: -5,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ── Video or Placeholder ──────────────────────────────
              _initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : _buildPlaceholder(isDark),

              // ── Gradient Overlay ──────────────────────────────────
              Positioned.fill(
                child: FadeTransition(
                  opacity: _overlayAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.5),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Center Play/Pause Button ──────────────────────────
              GestureDetector(
                onTap: _togglePlayPause,
                behavior: HitTestBehavior.translucent,
                child: FadeTransition(
                  opacity: _overlayAnimation,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ),

              // ── Bottom Control Bar ────────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _overlayAnimation,
                  child: _buildControlBar(isDark),
                ),
              ),

              // ── Autoplay Badge ────────────────────────────────────
              if (!_initialized)
                const SizedBox.shrink()
              else if (!_isPlaying)
                const SizedBox.shrink()
              else
                Positioned(
                  top: 16,
                  left: 16,
                  child: FadeTransition(
                    opacity: _overlayAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'LIVE',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
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

  Widget _buildControlBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          // Play/Pause
          _ControlButton(
            icon: _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            onTap: _togglePlayPause,
          ),
          const SizedBox(width: 12),
          // Progress bar
          Expanded(
            child: _initialized
                ? VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: AppColors.primary,
                      bufferedColor: Colors.white.withValues(alpha: 0.3),
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                    ),
                    padding: EdgeInsets.zero,
                  )
                : Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          // Mute/Unmute
          _ControlButton(
            icon: _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
            onTap: _toggleMute,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(bool isDark) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF0F2236), AppColors.darkBg],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFFE8F0FE), const Color(0xFFD0E1FF)],
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.movie_creation_outlined,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add your video to',
              style: GoogleFonts.poppins(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.5)
                    : const Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'assets/videos/showcase.mp4',
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helper: small control icon button ──────────────────────────────────────
class _ControlButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ControlButton({required this.icon, required this.onTap});

  @override
  State<_ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<_ControlButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? Colors.white.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.1),
          ),
          child: Icon(widget.icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
