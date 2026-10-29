import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/bloc/theme_event.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../../../core/utils/url_helper.dart';

class MobileDrawer extends StatelessWidget {
  final int activeIndex;
  final Function(int) onSectionSelected;

  const MobileDrawer({
    super.key,
    required this.activeIndex,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navItems = [
      {'title': 'Home', 'icon': Icons.home_rounded},
      {'title': 'About', 'icon': Icons.person_rounded},
      {'title': 'Skills', 'icon': Icons.code_rounded},
      {'title': 'Projects', 'icon': Icons.apps_rounded},
      {'title': 'Experience', 'icon': Icons.work_rounded},
      {'title': 'Contact', 'icon': Icons.mail_rounded},
    ];

    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Flutter Developer',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Navigation Links
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: navItems.length,
                itemBuilder: (context, index) {
                  final item = navItems[index];
                  final isSelected = activeIndex == index;

                  return ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary),
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor:
                        AppColors.primary.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      onSectionSelected(index);
                    },
                  );
                },
              ),
            ),

            const Divider(height: 1),

            // Theme toggle row
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        state.isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        size: 20,
                        color: state.isDarkMode
                            ? AppColors.accentAmber
                            : AppColors.primaryDark,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        state.isDarkMode ? 'Dark Theme' : 'Light Theme',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Switch(
                        value: state.isDarkMode,
                        onChanged: (_) {
                          context.read<ThemeBloc>().add(const ThemeToggled());
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            // Social links footer in drawer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                    tooltip: 'GitHub',
                    onPressed: () =>
                        UrlHelper.launchExternal(AppConstants.githubUrl),
                  ),
                  if (AppConstants.linkedInUrl.isNotEmpty)
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.linkedin, size: 20),
                      tooltip: 'LinkedIn',
                      onPressed: () =>
                          UrlHelper.launchExternal(AppConstants.linkedInUrl),
                    ),
                  IconButton(
                    icon: const Icon(Icons.email_rounded, size: 22),
                    tooltip: 'Email',
                    onPressed: () => UrlHelper.launchEmail(
                      context: context,
                      email: AppConstants.email,
                      subject: AppConstants.emailSubject,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone_rounded, size: 22),
                    tooltip: 'Call',
                    onPressed: () => UrlHelper.launchPhone(
                      context: context,
                      phone: AppConstants.mobileDial,
                      displayPhone: AppConstants.mobileDisplay,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
