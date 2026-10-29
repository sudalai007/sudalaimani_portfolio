import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/custom_badge.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/project_entity.dart';
import 'project_placeholder_artwork.dart';

class ProjectDetailDialog extends StatelessWidget {
  final ProjectEntity project;

  const ProjectDetailDialog({
    super.key,
    required this.project,
  });

  static Future<void> show(BuildContext context, ProjectEntity project) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ProjectDetailDialog(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 760,
          maxHeight: size.height * 0.88,
        ),
        child: GlassContainer(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Artwork with close button
              Stack(
                children: [
                  ProjectPlaceholderArtwork(
                    project: project,
                    height: 220,
                  ),
                  Positioned(
                    top: 14,
                    right: 14,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withValues(alpha: 0.6),
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.close,
                            size: 18, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: 'Close',
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),

              // Scrollable Details Body
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header info
                      Row(
                        children: [
                          CustomBadge(
                            label: project.category,
                            color: project.gradientColors.first,
                            isFilled: true,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.verified_rounded,
                            size: 16,
                            color: AppColors.accentGreen,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Production Deployed',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.accentGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        project.title,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Full Description
                      Text(
                        project.fullDescription,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Key Architectural Highlights
                      Text(
                        'Key Engineering Highlights',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.highlights.map(
                        (highlight) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  highlight,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.4,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Technologies Used
                      Text(
                        'Technologies & Tooling',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies
                            .map((tech) => CustomBadge(label: tech))
                            .toList(),
                      ),
                      const SizedBox(height: 32),

                      // Actions
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => UrlHelper.launchExternal(
                              project.playStoreUrl,
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.googlePlay,
                              size: 16,
                            ),
                            label: const Text('View on Google Play'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                          ),
                          if (project.hasGithub)
                            OutlinedButton.icon(
                              onPressed: () => UrlHelper.launchExternal(
                                project.githubUrl!,
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.github,
                                size: 16,
                              ),
                              label: const Text('Source Repository'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ],
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

