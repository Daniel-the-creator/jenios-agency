import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../utils/scroll_service.dart';
import '../../utils/email_service.dart';

class CtaBanner extends StatefulWidget {
  const CtaBanner({super.key});

  @override
  State<CtaBanner> createState() => _CtaBannerState();
}

class _CtaBannerState extends State<CtaBanner>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  bool _loading = false;
  bool _failed = false;
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
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _loading = true;
      _failed = false;
    });

    final success = await EmailService.sendContactEmail(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      message: _messageController.text.trim(),
    );

    if (!mounted) return;
    setState(() {
      _loading = false;
      if (success) {
        _submitted = true;
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        _failed = true;
      }
    });
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
                Expanded(flex: 6, child: _buildContent(isWide)),
                const SizedBox(width: 40),
                Expanded(flex: 3, child: _buildMascot()),
              ],
            )
          : Column(
              children: [
                _buildMascot(),
                const SizedBox(height: 32),
                _buildContent(isWide),
              ],
            ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildContent(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Build\nSomething\nAmazing",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: isWide ? 42 : 34,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Have a project in mind? Tell us about it and we\'ll get back to you within 24 hours.',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Email row on wide, stacked on mobile
                isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _nameController,
                              hint: 'Your Name',
                              icon: Icons.person_outline_rounded,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Please enter your name.'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _emailController,
                              hint: 'Email Address',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter your email.';
                                }
                                final emailRegex = RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegex.hasMatch(val.trim())) {
                                  return 'Enter a valid email address.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Your Name',
                            icon: Icons.person_outline_rounded,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Please enter your name.'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Email Address',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Please enter your email.';
                              }
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                              if (!emailRegex.hasMatch(val.trim())) {
                                return 'Enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                const SizedBox(height: 12),
                // Message field
                _buildTextField(
                  controller: _messageController,
                  hint: 'Tell us about your project...',
                  icon: Icons.chat_bubble_outline_rounded,
                  maxLines: 4,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please describe your project.'
                      : null,
                ),
                const SizedBox(height: 16),
                // Error message
                if (_failed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      '⚠️ Failed to send. Please try again or email us directly at Jeniousagency@gmail.com',
                      style: GoogleFonts.poppins(
                        color: Colors.redAccent.shade100,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                // Submit button
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textLight,
          fontSize: 13.5,
        ),
        prefixIcon: maxLines == 1
            ? Icon(icon, color: AppColors.primary, size: 18)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: maxLines > 1 ? 16 : 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 50),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 50),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 50),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 50),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 50),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Message sent! 🎉',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "We've received your enquiry and will get back to you within 24 hours.",
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: widget.loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2.5),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 10),
                    Text(
                      'Send Message',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
