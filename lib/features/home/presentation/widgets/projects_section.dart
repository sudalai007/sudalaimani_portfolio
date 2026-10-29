import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../projects/presentation/bloc/project_filter_bloc.dart';
import '../../../projects/presentation/bloc/project_filter_event.dart';
import '../../../projects/presentation/bloc/project_filter_state.dart';
import '../../../projects/presentation/widgets/project_card.dart';
import '../../../projects/presentation/widgets/project_detail_dialog.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);

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
              tag: 'Portfolio',
              title: AppStrings.projectsTitle,
              subtitle: AppStrings.projectsSubtitle,
            ),

            // Filters and Search Header
            BlocBuilder<ProjectFilterBloc, ProjectFilterState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // Category Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: state.categories.map((category) {
                          final isSelected = state.selectedCategory == category;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (_) {
                                context
                                    .read<ProjectFilterBloc>()
                                    .add(CategorySelected(category));
                              },
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 13,
                              ),
                              selectedColor: AppColors.primary,
                              backgroundColor: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFF1F5F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isDark
                                          ? Colors.white.withValues(alpha: 0.08)
                                          : Colors.black.withValues(alpha: 0.06)),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Project Grid with Dynamic Adaptive Aspect Ratio
                    if (state.status == ProjectStatus.loading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state.filteredProjects.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No projects match the selected filter.',
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;

                          // Responsive column calculation
                          final int crossAxisCount;
                          if (width < 660) {
                            crossAxisCount = 1;
                          } else if (width < 1000) {
                            crossAxisCount = 2;
                          } else {
                            crossAxisCount = 3;
                          }

                          const double spacing = 24.0;
                          final double cardWidth = (width -
                                  spacing * (crossAxisCount - 1)) /
                              crossAxisCount;

                          // Target height guarantees ample space for Artwork (150) + Info + Badges + Buttons
                          final double targetHeight =
                              width < 480 ? 490.0 : (width < 768 ? 485.0 : 480.0);
                          final double childAspectRatio = cardWidth / targetHeight;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.filteredProjects.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: spacing,
                              crossAxisSpacing: spacing,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              final project = state.filteredProjects[index];
                              return AnimatedSection(
                                delay: Duration(milliseconds: index * 100),
                                child: ProjectCard(
                                  project: project,
                                  onDetailsTap: () {
                                    ProjectDetailDialog.show(context, project);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
