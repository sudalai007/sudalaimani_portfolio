import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class BackgroundMesh extends StatelessWidget {
  final Widget child;

  const BackgroundMesh({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // 1. Full Body Ambient Gradient Surface
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.darkBodyGradient
                  : AppColors.lightBodyGradient,
            ),
          ),
        ),

        // 2. Top-Center Hero Futuristic Cyan & Azure Radial Glow
        Positioned(
          top: -160,
          left: 0,
          right: 0,
          height: 750,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.3),
                radius: 0.95,
                colors: isDark
                    ? [
                        const Color(0xFF06B6D4).withValues(alpha: 0.16),
                        const Color(0xFF3B82F6).withValues(alpha: 0.12),
                        const Color(0xFF6366F1).withValues(alpha: 0.05),
                        Colors.transparent,
                      ]
                    : [
                        const Color(0xFF3B82F6).withValues(alpha: 0.09),
                        const Color(0xFF06B6D4).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                stops: const [0.0, 0.45, 0.75, 1.0],
              ),
            ),
          ),
        ),

        // 3. Top-Right Warm Sunset Magenta Bloom (High Visual Engagement)
        Positioned(
          top: 100,
          right: -120,
          width: 580,
          height: 580,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: isDark
                    ? [
                        const Color(0xFFEC4899).withValues(alpha: 0.11),
                        const Color(0xFF8B5CF6).withValues(alpha: 0.07),
                        Colors.transparent,
                      ]
                    : [
                        const Color(0xFFF43F5E).withValues(alpha: 0.05),
                        const Color(0xFF8B5CF6).withValues(alpha: 0.03),
                        Colors.transparent,
                      ],
              ),
            ),
          ),
        ),

        // 4. Midfield Projects & Skills Royal Violet & Indigo Glow
        Positioned(
          top: 1300,
          left: -140,
          width: 650,
          height: 650,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: isDark
                    ? [
                        const Color(0xFF6366F1).withValues(alpha: 0.15),
                        const Color(0xFF8B5CF6).withValues(alpha: 0.09),
                        Colors.transparent,
                      ]
                    : [
                        const Color(0xFF6366F1).withValues(alpha: 0.06),
                        Colors.transparent,
                      ],
              ),
            ),
          ),
        ),

        // 5. Lower Contact Section Warm Emerald & Cyan Connection Glow
        Positioned(
          bottom: 150,
          right: -100,
          width: 650,
          height: 650,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: isDark
                    ? [
                        const Color(0xFF10B981).withValues(alpha: 0.12),
                        const Color(0xFF06B6D4).withValues(alpha: 0.08),
                        Colors.transparent,
                      ]
                    : [
                        const Color(0xFF10B981).withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
              ),
            ),
          ),
        ),

        // 6. Subtle High-Tech Geometric Grid Texture
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPatternPainter(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.018)
                  : Colors.black.withValues(alpha: 0.022),
              spacing: 38.0,
            ),
          ),
        ),

        // 7. Foreground Content
        child,
      ],
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  _GridPatternPainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPatternPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.spacing != spacing;
}
