import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final bool isFilled;
  final VoidCallback? onTap;

  const CustomBadge({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.isFilled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = color ?? AppColors.primary;

    final bgColor = isFilled
        ? accent.withValues(alpha: isDark ? 0.2 : 0.12)
        : (isDark
            ? const Color(0xFF1E293B).withValues(alpha: 0.6)
            : const Color(0xFFF1F5F9));

    final borderColor = isFilled
        ? accent.withValues(alpha: 0.4)
        : (isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.06));

    final textColor = isFilled
        ? accent
        : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textColor,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: content,
      );
    }

    return content;
  }
}

