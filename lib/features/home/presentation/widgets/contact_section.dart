import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../contact/presentation/widgets/contact_form.dart';
import '../../../contact/presentation/widgets/contact_info_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
              tag: 'Get In Touch',
              title: AppStrings.contactTitle,
              subtitle: AppStrings.contactSubtitle,
            ),
            if (isMobile) ...[
              _buildContactInfoList(context, theme, isDark),
              const SizedBox(height: 32),
              const ContactForm(),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildContactInfoList(context, theme, isDark),
                  ),
                  const SizedBox(width: 40),
                  const Expanded(
                    flex: 5,
                    child: ContactForm(),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoList(
    BuildContext context,
    ThemeData theme,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Build Something Exceptional",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Whether you are seeking a skilled Flutter developer for your team, have an enterprise project to build, or would like to discuss cross-platform mobile architecture, feel free to reach out directly.',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        const SizedBox(height: 24),

        // Email Card
        ContactInfoCard(
          icon: Icons.email_rounded,
          label: 'Direct Email',
          value: AppConstants.email,
          onTap: () => UrlHelper.launchEmail(
            context: context,
            email: AppConstants.email,
            subject: AppConstants.emailSubject,
          ),
          onCopy: () => UrlHelper.copyToClipboard(
            context,
            AppConstants.email,
            AppStrings.emailCopiedMessage,
          ),
        ),
        const SizedBox(height: 14),

        // Phone Card
        ContactInfoCard(
          icon: Icons.phone_rounded,
          label: 'Mobile Number',
          value: AppConstants.mobileDisplay,
          onTap: () => UrlHelper.launchPhone(
            context: context,
            phone: AppConstants.mobileDial,
            displayPhone: AppConstants.mobileDisplay,
          ),
          onCopy: () => UrlHelper.copyToClipboard(
            context,
            AppConstants.mobileDisplay,
            AppStrings.phoneCopiedMessage,
          ),
        ),
        const SizedBox(height: 14),

        // GitHub Card
        ContactInfoCard(
          icon: FontAwesomeIcons.github,
          label: 'GitHub Profile',
          value: 'github.com/sudalai007',
          onTap: () => UrlHelper.launchExternal(AppConstants.githubUrl),
          onCopy: () => UrlHelper.copyToClipboard(
            context,
            AppConstants.githubUrl,
            'GitHub profile URL copied to clipboard!',
          ),
        ),
        const SizedBox(height: 14),

        // LinkedIn Card (Configurable)
        if (AppConstants.linkedInUrl.isNotEmpty) ...[
          ContactInfoCard(
            icon: FontAwesomeIcons.linkedin,
            label: 'LinkedIn Profile',
            value: 'linkedin.com/in/sudalaimani-v',
            onTap: () => UrlHelper.launchExternal(AppConstants.linkedInUrl),
            onCopy: () => UrlHelper.copyToClipboard(
              context,
              AppConstants.linkedInUrl,
              'LinkedIn profile URL copied to clipboard!',
            ),
          ),
        ],
      ],
    );
  }
}

