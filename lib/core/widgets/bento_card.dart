import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A reusable Bento Grid card with hover effects (lift + border glow).
class BentoCard extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Gradient? gradient;
  final bool enableHover;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const BentoCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.gradient,
    this.enableHover = true,
    this.padding,
    this.borderRadius = 16,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  State<BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<BentoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final br = BorderRadius.circular(widget.borderRadius);

    final defaultBg = isDark
        ? const Color(0xFF131B2E).withValues(alpha: 0.9)
        : Colors.white;

    final borderColor = _isHovered && widget.enableHover
        ? AppColors.primary.withValues(alpha: isDark ? 0.55 : 0.45)
        : (isDark
            ? Colors.white.withValues(alpha: 0.09)
            : Colors.black.withValues(alpha: 0.07));

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      width: widget.width,
      height: widget.height,
      transform: Matrix4.translationValues(
        0.0,
        (_isHovered && widget.enableHover) ? -4.0 : 0.0,
        0.0,
      ),
      decoration: BoxDecoration(
        color: widget.gradient == null
            ? (widget.backgroundColor ?? defaultBg)
            : null,
        gradient: widget.gradient,
        borderRadius: br,
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: _isHovered && widget.enableHover
                ? AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.1)
                : Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: _isHovered && widget.enableHover ? 28 : 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: br,
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(20),
          child: widget.child,
        ),
      ),
    );

    if (!widget.enableHover) return content;

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.onTap != null
          ? GestureDetector(onTap: widget.onTap, child: content)
          : content,
    );
  }
}

