import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Extension to get theme-aware colors throughout the app.
extension ThemeColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Background / surface colors
  Color get bgColor => isDark ? AppColors.darkBg : AppColors.background;
  Color get surfaceColor => isDark ? AppColors.darkCard : AppColors.surface;
  Color get cardColor => isDark ? AppColors.darkCard : Colors.white;

  // Text colors
  Color get textDarkColor => isDark ? Colors.white : AppColors.textDark;
  Color get textMediumColor =>
      isDark ? Colors.white.withValues(alpha: 0.75) : AppColors.textMedium;
  Color get textLightColor =>
      isDark ? Colors.white.withValues(alpha: 0.55) : AppColors.textLight;
  Color get textMutedColor =>
      isDark ? Colors.white.withValues(alpha: 0.35) : AppColors.textMuted;

  // Border
  Color get borderColor =>
      isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.border;

  // Section tag (pill label)
  Color get tagBgColor =>
      isDark ? AppColors.primary.withValues(alpha: 0.18) : AppColors.primaryLight;

  // Input fill
  Color get inputFillColor => isDark ? AppColors.darkCard : Colors.white;
}
