import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isSecondary = false,
    this.width,
    this.height = 48.0,
    this.padding,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryBg = LinearGradient(
      colors: _isHovered
          ? [const Color(0xFF2563EB), const Color(0xFF4F46E5)]
          : [AppColors.primary, AppColors.secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final secondaryBg = isDark
        ? (_isHovered
            ? const Color(0xFF1E293B)
            : const Color(0xFF131B2E).withValues(alpha: 0.8))
        : (_isHovered
            ? const Color(0xFFE2E8F0)
            : Colors.white.withValues(alpha: 0.9));

    final secondaryBorder = isDark
        ? (_isHovered
            ? AppColors.primary.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.12))
        : (_isHovered
            ? AppColors.primary.withValues(alpha: 0.6)
            : Colors.black.withValues(alpha: 0.1));

    final textColor = widget.isSecondary
        ? (isDark ? Colors.white : AppColors.lightTextPrimary)
        : Colors.white;

    return MouseRegion(
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -2.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          gradient: widget.isSecondary ? null : primaryBg,
          color: widget.isSecondary ? secondaryBg : null,
          borderRadius: BorderRadius.circular(10),
          border: widget.isSecondary
              ? Border.all(color: secondaryBorder, width: 1.4)
              : null,
          boxShadow: [
            if (_isHovered && !widget.isSecondary)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            if (_isHovered && widget.isSecondary)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 18,
                      color: textColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
