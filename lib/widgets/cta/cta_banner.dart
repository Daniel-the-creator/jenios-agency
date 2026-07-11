import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/scroll_service.dart';

class CtaBanner extends StatefulWidget {
  const CtaBanner({super.key});

  @override
  State<CtaBanner> createState() => _CtaBannerState();
}

class _CtaBannerState extends State<CtaBanner>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  bool _loading = false;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loading = false;
      _submitted = true;
    });
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final scrollService = ScrollService();

    return Container(
      key: scrollService.contactKey,
      decoration: const BoxDecoration(gradient: AppColors.ctaGradient),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 28,
        vertical: 72,
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: _buildContent()),
                const SizedBox(width: 40),
                Expanded(flex: 3, child: _buildMascot()),
              ],
            )
          : Column(
              children: [
                _buildMascot(),
                const SizedBox(height: 32),
                _buildContent(),
              ],
            ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Build\nSomething\nAmazing",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Join hundreds of businesses growing with Jenios.\nShare your email and we\'ll reach out.',
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        if (_submitted)
          _SuccessMessage()
        else
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.poppins(
                        color: AppColors.textDark, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter your email address',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: Colors.red, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                            color: Colors.red, width: 2),
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email.';
                      }
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(val)) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                _SubmitButton(
                  loading: _loading,
                  onTap: _handleSubmit,
                ),
              ],
            ),
          ),
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
      child: Image.asset(
        'assets/images/mascot.png',
        height: 280,
      ),
    );
  }
}

class _SuccessMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: AppColors.primary, size: 28),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                "We'll contact you shortly.",
                style: GoogleFonts.poppins(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale();
  }
}

class _SubmitButton extends StatefulWidget {
  final bool loading;
  final VoidCallback onTap;

  const _SubmitButton({required this.loading, required this.onTap});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: widget.loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
