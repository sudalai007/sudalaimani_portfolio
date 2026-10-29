import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/custom_badge.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    final skillCategories = [
      {
        'title': 'Core Languages',
        'icon': Icons.terminal_rounded,
        'color': const Color(0xFF3B82F6),
        'skills': ['Dart', 'Kotlin', 'Swift'],
      },
      {
        'title': 'Flutter Development',
        'icon': Icons.flutter_dash_rounded,
        'color': const Color(0xFF06B6D4),
        'skills': [
          'Flutter Framework',
          'Material 3',
          'Responsive UI',
          'Custom Widgets',
          'Implicit & Explicit Animations',
          'Canvas & CustomPainters',
        ],
      },
      {
        'title': 'State Management',
        'icon': Icons.hub_rounded,
        'color': const Color(0xFF8B5CF6),
        'skills': [
          'flutter_bloc',
          'Cubit',
          'Provider',
          'GetX (as required)',
        ],
      },
      {
        'title': 'Architecture & Design',
        'icon': Icons.architecture_rounded,
        'color': const Color(0xFF6366F1),
        'skills': [
          'Clean Architecture',
          'SOLID Principles',
          'Repository Pattern',
          'Dependency Injection (GetIt)',
          'Feature-First Structure',
        ],
      },
      {
        'title': 'Networking & Cloud',
        'icon': Icons.cloud_sync_rounded,
        'color': const Color(0xFF10B981),
        'skills': [
          'REST APIs',
          'Dio & Http',
          'JSON Serialization',
          'Firebase Services',
          'Firebase Cloud Messaging (FCM)',
        ],
      },
      {
        'title': 'Storage & Offline Support',
        'icon': Icons.storage_rounded,
        'color': const Color(0xFFF59E0B),
        'skills': [
          'Hive Database',
          'SQLite / Sqflite',
          'Local Persistence',
          'Offline-First Workflows',
          'Data Synchronization',
        ],
      },
      {
        'title': 'Navigation & Native Bridges',
        'icon': Icons.alt_route_rounded,
        'color': const Color(0xFFEC4899),
        'skills': [
          'go_router',
          'Deep Linking',
          'Android Platform Channels',
          'iOS Platform Channels',
          'Background Geolocation & Services',
        ],
      },
      {
        'title': 'Quality & DevOps Tools',
        'icon': Icons.build_circle_rounded,
        'color': const Color(0xFF14B8A6),
        'skills': [
          'Git & GitHub',
          'Unit Testing',
          'Widget Testing',
          'Integration Testing',
          'CI/CD Pipelines',
        ],
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
              tag: 'Capabilities',
              title: AppStrings.skillsTitle,
              subtitle: AppStrings.skillsSubtitle,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skillCategories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: isMobile ? 1.9 : 1.35,
              ),
              itemBuilder: (context, index) {
                final category = skillCategories[index];
                return AnimatedSection(
                  delay: Duration(milliseconds: index * 80),
                  child: _SkillCategoryCard(
                    title: category['title'] as String,
                    icon: category['icon'] as IconData,
                    color: category['color'] as Color,
                    skills: category['skills'] as List<String>,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;

  const _SkillCategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark
        ? const Color(0xFF131B2E).withValues(alpha: 0.8)
        : Colors.white;

    final borderColor = _isHovered
        ? widget.color.withValues(alpha: isDark ? 0.6 : 0.5)
        : (isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.08));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        child: GlassContainer(
          customBackgroundColor: cardBg,
          customBorderColor: borderColor,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Title Header
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: isDark ? 0.2 : 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: widget.color.withValues(alpha: isDark ? 0.4 : 0.3),
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Chips
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.skills.map((skill) {
                      return CustomBadge(
                        label: skill,
                        color: widget.color,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
