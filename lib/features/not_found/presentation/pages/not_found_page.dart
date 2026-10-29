import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../home/presentation/widgets/background_mesh.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundMesh(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GlassContainer(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '404',
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Page Not Found',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The page or route you were looking for does not exist.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  GradientButton(
                    label: 'Back to Portfolio',
                    icon: Icons.home_rounded,
                    onPressed: () => context.go('/'),
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

