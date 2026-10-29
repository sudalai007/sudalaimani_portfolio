import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/bloc/theme_event.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/url_helper.dart';

class NavigationBarWidget extends StatelessWidget {
  final int activeIndex;
  final Function(int) onSectionSelected;
  final VoidCallback onOpenDrawer;

  const NavigationBarWidget({
    super.key,
    required this.activeIndex,
    required this.onSectionSelected,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = ResponsiveHelper.isDesktop(context);

    final navItems = [
      'Home',
      'About',
      'Skills',
      'Projects',
      'Experience',
      'Contact',
    ];

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: 72,
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.horizontalPadding(context),
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkBackground.withValues(alpha: 0.8)
                : AppColors.lightBackground.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Logo / Name Brand
              InkWell(
                onTap: () => onSectionSelected(0),
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'S',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: -0.2,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                        const Text(
                          'Flutter Developer',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            letterSpacing: 0.2,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Desktop Navigation Links
              if (isDesktop) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(navItems.length, (index) {
                    final isSelected = activeIndex == index;
                    return _NavLinkItem(
                      title: navItems[index],
                      isSelected: isSelected,
                      onTap: () => onSectionSelected(index),
                    );
                  }),
                ),
                const SizedBox(width: 16),

                // Vertical Divider
                Container(
                  height: 24,
                  width: 1,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
                const SizedBox(width: 16),

                // GitHub icon
                IconButton(
                  tooltip: 'GitHub Profile',
                  icon: const FaIcon(FontAwesomeIcons.github, size: 18),
                  onPressed: () => UrlHelper.launchExternal(AppConstants.githubUrl),
                ),

                // LinkedIn icon
                if (AppConstants.linkedInUrl.isNotEmpty)
                  IconButton(
                    tooltip: 'LinkedIn Profile',
                    icon: const FaIcon(FontAwesomeIcons.linkedin, size: 18),
                    onPressed: () =>
                        UrlHelper.launchExternal(AppConstants.linkedInUrl),
                  ),

                const SizedBox(width: 8),
              ],

              // Theme Switcher Toggle
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return IconButton(
                    tooltip: themeState.isDarkMode
                        ? 'Switch to Light Mode'
                        : 'Switch to Dark Mode',
                    icon: Icon(
                      themeState.isDarkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      size: 20,
                      color: themeState.isDarkMode
                          ? AppColors.accentAmber
                          : AppColors.primaryDark,
                    ),
                    onPressed: () {
                      context.read<ThemeBloc>().add(const ThemeToggled());
                    },
                  );
                },
              ),

              // Mobile Drawer Hamburger Menu Button
              if (!isDesktop) ...[
                const SizedBox(width: 6),
                IconButton(
                  tooltip: 'Open Menu',
                  icon: const Icon(Icons.menu_rounded, size: 24),
                  onPressed: onOpenDrawer,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLinkItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavLinkItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<_NavLinkItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = widget.isSelected
        ? AppColors.primary
        : (_isHovered
            ? (isDark ? Colors.white : Colors.black)
            : (isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: widget.isSelected
                ? AppColors.primary.withValues(alpha: isDark ? 0.12 : 0.08)
                : (_isHovered
                    ? (isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.04))
                    : Colors.transparent),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  widget.isSelected ? FontWeight.w700 : FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
