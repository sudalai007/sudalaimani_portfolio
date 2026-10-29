import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);

    final careerMilestones = [
      {
        'role': 'Flutter Developer & Mobile Application Engineer',
        'duration': '3+ Years Experience',
        'subtitle': 'Production Mobile Architecture & Lifecycle Engineering',
        'details': [
          'Engineered multiple production-grade mobile applications deployed to the Google Play Store.',
          'Formulated offline-first data synchronization architectures with SQLite/Hive and background tasks.',
          'Built custom native platform channel bridges for location tracking, sensors, and hardware peripherals.',
          'Streamlined push notification delivery and deep linking flows with Firebase Cloud Messaging.',
          'Designed modular codebases adhering strictly to Clean Architecture, SOLID principles, and BLoC state management.',
        ],
      },
    ];

    final highlights = [
      {
        'title': 'Cross-Platform Mastery',
        'desc': 'Expertise in single-codebase parity for Android and iOS.',
        'icon': Icons.phone_android_rounded,
      },
      {
        'title': 'Offline-First Architect',
        'desc': 'Zero-data-loss persistence and automated background syncing.',
        'icon': Icons.wifi_off_rounded,
      },
      {
        'title': 'Native Bridge Integration',
        'desc': 'Seamless Kotlin/Swift platform channels integration.',
        'icon': Icons.developer_board_rounded,
      },
      {
        'title': 'API & Realtime Systems',
        'desc': 'RESTful APIs, WebSocket events, and FCM push notifications.',
        'icon': Icons.cell_tower_rounded,
      },
      {
        'title': 'Performance & Maintainability',
        'desc': 'Sub-16ms 60 FPS rendering, leak profiling, and automated testing.',
        'icon': Icons.speed_rounded,
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
              tag: 'Career Track',
              title: AppStrings.experienceTitle,
              subtitle: AppStrings.experienceSubtitle,
            ),
            isMobile
                ? Column(
                    children: [
                      AnimatedSection(
                        child: _buildTimelineCard(
                            theme, isDark, careerMilestones.first),
                      ),
                      const SizedBox(height: 32),
                      AnimatedSection(
                        delay: const Duration(milliseconds: 120),
                        child: _buildHighlightsGrid(
                            theme, isDark, highlights, 1),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: AnimatedSection(
                          child: _buildTimelineCard(
                            theme,
                            isDark,
                            careerMilestones.first,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 5,
                        child: AnimatedSection(
                          delay: const Duration(milliseconds: 120),
                          child: _buildHighlightsGrid(
                            theme,
                            isDark,
                            highlights,
                            2,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard(
    ThemeData theme,
    bool isDark,
    Map<String, dynamic> item,
  ) {
    final details = item['details'] as List<String>;

    return GlassContainer(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.work_history_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['role'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['duration'] as String,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            item['subtitle'] as String,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...details.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.arrow_right_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsGrid(
    ThemeData theme,
    bool isDark,
    List<Map<String, dynamic>> highlights,
    int crossAxisCount,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            'Core Competencies',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ...highlights.map((h) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassContainer(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(
                          alpha: isDark ? 0.2 : 0.1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        h['icon'] as IconData,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            h['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            h['desc'] as String,
                            style: TextStyle(
                              fontSize: 12,
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
              ),
            )),
      ],
    );
  }
}

