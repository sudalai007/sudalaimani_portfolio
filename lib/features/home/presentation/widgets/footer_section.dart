import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/url_helper.dart';

class FooterSection extends StatelessWidget {
  final Function(int) onSectionSelected;

  const FooterSection({
    super.key,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);
    final currentYear = DateTime.now().year;

    final navLinks = [
      {'title': 'Home', 'index': 0},
      {'title': 'About', 'index': 1},
      {'title': 'Skills', 'index': 2},
      {'title': 'Projects', 'index': 3},
      {'title': 'Experience', 'index': 4},
      {'title': 'Contact', 'index': 5},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF070B14) : const Color(0xFFF1F5F9),
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.horizontalPadding(context),
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              if (isMobile) ...[
                _buildBrandColumn(isDark),
                const SizedBox(height: 24),
                _buildNavWrap(navLinks, isDark),
                const SizedBox(height: 24),
                _buildSocialIcons(context),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBrandColumn(isDark),
                    _buildNavWrap(navLinks, isDark),
                    _buildSocialIcons(context),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              Divider(
                color: isDark ? AppColors.darkBorderSubtle : AppColors.lightBorderSubtle,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '© $currentYear ${AppConstants.fullName}. ${AppStrings.copyright}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkTextMuted
                            : AppColors.lightTextMuted,
                      ),
                    ),
                  ),
                  Text(
                    AppStrings.footerTagline,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.darkTextMuted
                          : AppColors.lightTextMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandColumn(bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.fullName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            const Text(
              AppConstants.professionalTitle,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavWrap(List<Map<String, dynamic>> links, bool isDark) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: links.map((link) {
        return InkWell(
          onTap: () => onSectionSelected(link['index'] as int),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              link['title'] as String,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSocialIcons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.github, size: 16),
          tooltip: 'GitHub',
          onPressed: () => UrlHelper.launchExternal(AppConstants.githubUrl),
        ),
        if (AppConstants.linkedInUrl.isNotEmpty)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.linkedin, size: 16),
            tooltip: 'LinkedIn',
            onPressed: () => UrlHelper.launchExternal(AppConstants.linkedInUrl),
          ),
        IconButton(
          icon: const Icon(Icons.email_outlined, size: 18),
          tooltip: 'Email',
          onPressed: () => UrlHelper.launchEmail(
            context: context,
            email: AppConstants.email,
            subject: AppConstants.emailSubject,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.phone_outlined, size: 18),
          tooltip: 'Call',
          onPressed: () => UrlHelper.launchPhone(
            context: context,
            phone: AppConstants.mobileDial,
            displayPhone: AppConstants.mobileDisplay,
          ),
        ),
      ],
    );
  }
}
