import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);

    final pillars = [
      {
        'title': 'Cross-Platform Excellence',
        'desc':
            'Building responsive, high-fidelity applications across Android, iOS, and Web with a single Dart codebase.',
        'icon': Icons.devices_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'Clean Architecture & SOLID',
        'desc':
            'Separation of concerns between Presentation, Domain, and Data layers for long-term maintainability and testing.',
        'icon': Icons.account_tree_rounded,
        'color': const Color(0xFF6366F1),
      },
      {
        'title': 'Offline-First & Background Sync',
        'desc':
            'Local persistence using Hive and SQLite combined with resilient background sync queues for uncompromised field usage.',
        'icon': Icons.sync_problem_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Native Platform Integration',
        'desc':
            'Bridging native Android (Kotlin) and iOS (Swift) APIs using Flutter platform channels for custom device features.',
        'icon': Icons.integration_instructions_rounded,
        'color': const Color(0xFFF59E0B),
      },
    ];

    return AnimatedSection(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.horizontalPadding(context),
          vertical: isMobile ? 48 : 80,
        ),
        constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
        child: Column(
          children: [
            const SectionHeader(
              tag: 'About Me',
              title: AppStrings.aboutTitle,
              subtitle: AppStrings.aboutSubtitle,
            ),
            if (isMobile) ...[
              AnimatedSection(child: _buildAboutText(theme, isDark)),
              const SizedBox(height: 32),
              ...pillars.asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AnimatedSection(
                      delay: Duration(milliseconds: e.key * 100),
                      child: _buildPillarCard(e.value, isDark),
                    ),
                  )),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: AnimatedSection(child: _buildAboutText(theme, isDark)),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: pillars
                          .asMap()
                          .entries
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: AnimatedSection(
                                  delay: Duration(milliseconds: e.key * 100),
                                  child: _buildPillarCard(e.value, isDark),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAboutText(ThemeData theme, bool isDark) {
    final bodyColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GlassContainer(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Professional Summary',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            AppStrings.aboutP1,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: bodyColor,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            AppStrings.aboutP2,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: bodyColor,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            AppStrings.aboutP3,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: bodyColor,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillarCard(Map<String, dynamic> pillar, bool isDark) {
    final color = pillar['color'] as Color;

    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.2 : 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: color.withValues(alpha: isDark ? 0.4 : 0.25),
              ),
            ),
            child: Icon(
              pillar['icon'] as IconData,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pillar['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pillar['desc'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

