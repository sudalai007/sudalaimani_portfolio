import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/custom_badge.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../di/service_locator.dart';
import '../../../home/presentation/widgets/background_mesh.dart';
import '../../../projects/domain/entities/project_entity.dart';
import '../../../projects/domain/repositories/projects_repository.dart';
import '../../../projects/presentation/widgets/project_placeholder_artwork.dart';

class ProjectDetailPage extends StatefulWidget {
  final String slug;

  const ProjectDetailPage({super.key, required this.slug});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  ProjectEntity? _project;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  Future<void> _loadProject() async {
    final repo = sl<ProjectsRepository>();
    final project = await repo.getProjectBySlug(widget.slug);
    if (mounted) {
      setState(() {
        _project = project;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(
          _project?.title ?? 'Project Details',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.home_rounded, size: 18),
            label: const Text('Portfolio'),
            onPressed: () => context.go('/'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BackgroundMesh(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _project == null
                ? _buildNotFoundView(context, isDark)
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.horizontalPadding(context),
                      vertical: 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 900,
                        ),
                        child: _buildProjectContent(
                          context,
                          theme,
                          isDark,
                          isMobile,
                          _project!,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget _buildNotFoundView(BuildContext context, bool isDark) {
    return Center(
      child: GlassContainer(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: AppColors.accentRose,
            ),
            const SizedBox(height: 16),
            const Text(
              'Project Not Found',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'The requested project could not be found or may have been moved.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GradientButton(
              label: 'Return to Portfolio',
              icon: Icons.home_rounded,
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectContent(
    BuildContext context,
    ThemeData theme,
    bool isDark,
    bool isMobile,
    ProjectEntity project,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Artwork card
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ProjectPlaceholderArtwork(
            project: project,
            height: isMobile ? 220 : 340,
          ),
        ),
        const SizedBox(height: 32),

        // Title and Category row
        GlassContainer(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    size: 18,
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Google Play Production',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                project.title,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                project.fullDescription,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.7,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Architectural Highlights
              Text(
                'Key Architectural Highlights',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ...project.highlights.map(
                (h) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          h,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
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
              const SizedBox(height: 32),

              // Technologies
              Text(
                'Technologies & Integrations',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies
                    .map((tech) => CustomBadge(label: tech))
                    .toList(),
              ),
              const SizedBox(height: 40),

              // External Launch Buttons
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  GradientButton(
                    label: 'Open in Google Play Store',
                    icon: FontAwesomeIcons.googlePlay,
                    onPressed: () =>
                        UrlHelper.launchExternal(project.playStoreUrl),
                  ),
                  if (project.hasGithub)
                    GradientButton(
                      label: 'View Repository',
                      icon: FontAwesomeIcons.github,
                      isSecondary: true,
                      onPressed: () =>
                          UrlHelper.launchExternal(project.githubUrl!),
                    ),
                  GradientButton(
                    label: 'Contact Sudalaimani',
                    icon: Icons.mail_outline_rounded,
                    isSecondary: true,
                    onPressed: () => UrlHelper.launchEmail(
                      context: context,
                      email: AppConstants.email,
                      subject: 'Inquiry regarding ${project.title}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

