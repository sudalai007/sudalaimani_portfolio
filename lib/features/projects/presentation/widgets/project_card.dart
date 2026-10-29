import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/custom_badge.dart';
import '../../domain/entities/project_entity.dart';
import 'project_placeholder_artwork.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;
  final VoidCallback onDetailsTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onDetailsTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark
        ? const Color(0xFF131B2E).withValues(alpha: 0.88)
        : Colors.white;

    final borderColor = _isHovered
        ? AppColors.primary.withValues(alpha: isDark ? 0.7 : 0.6)
        : (isDark
            ? Colors.white.withValues(alpha: 0.09)
            : Colors.black.withValues(alpha: 0.08));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -6.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.16)
                  : (isDark
                      ? Colors.black.withValues(alpha: 0.32)
                      : const Color(0xFF64748B).withValues(alpha: 0.08)),
              blurRadius: _isHovered ? 24 : 14,
              offset: Offset(0, _isHovered ? 12 : 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Visual artwork header
              ProjectPlaceholderArtwork(
                project: widget.project,
                height: 150,
              ),

              // 2. Card interactive content body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      CustomBadge(
                        label: widget.project.category,
                        color: widget.project.gradientColors.first,
                        isFilled: true,
                      ),
                      const SizedBox(height: 8),

                      // Title
                      Text(
                        widget.project.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 6),

                      // Description (cleanly clamped to max 3 lines)
                      Text(
                        widget.project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                              height: 1.4,
                              fontSize: 13,
                            ),
                      ),

                      // Flexible spacer guarantees tags and buttons are neatly bottom-pinned
                      const Spacer(),
                      const SizedBox(height: 6),

                      // Technology tags (concise for cards, full stack in detail view)
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.technologies
                            .take(3)
                            .map((tech) => CustomBadge(label: tech))
                            .toList(),
                      ),
                      const SizedBox(height: 12),

                      // Action Buttons
                      Row(
                        children: [
                          // Play Store Action
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => UrlHelper.launchExternal(
                                widget.project.playStoreUrl,
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.googlePlay,
                                size: 13,
                              ),
                              label: const Text(
                                'Google Play',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Details Action
                          OutlinedButton(
                            onPressed: widget.onDetailsTap,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Optional GitHub Repo Action
                          if (widget.project.hasGithub) ...[
                            const SizedBox(width: 6),
                            IconButton(
                              onPressed: () => UrlHelper.launchExternal(
                                widget.project.githubUrl!,
                              ),
                              icon: const FaIcon(
                                FontAwesomeIcons.github,
                                size: 17,
                              ),
                              tooltip: 'GitHub Repository',
                            ),
                          ],
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
