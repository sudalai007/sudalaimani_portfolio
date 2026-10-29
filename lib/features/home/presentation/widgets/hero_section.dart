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
import '../../../../core/widgets/bento_card.dart';
import '../../../../core/widgets/gradient_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onContactMe;

  const HeroSection({
    super.key,
    required this.onExploreProjects,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.horizontalPadding(context),
        vertical: isMobile ? 28 : 48,
      ),
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      child: isMobile
          ? _MobileBentoLayout(
              onExploreProjects: onExploreProjects,
              onContactMe: onContactMe,
            )
          : _DesktopBentoLayout(
              onExploreProjects: onExploreProjects,
              onContactMe: onContactMe,
              isTablet: isTablet,
            ),
    );
  }
}

// ─────────────────────────────────────────────
// Desktop Bento Grid (>= 900 px)
// ─────────────────────────────────────────────
class _DesktopBentoLayout extends StatelessWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onContactMe;
  final bool isTablet;

  const _DesktopBentoLayout({
    required this.onExploreProjects,
    required this.onContactMe,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    const gap = 16.0;
    const animDur = Duration(milliseconds: 120);

    return Column(
      children: [
        // ── Row 1 ──────────────────────────────────────────────────
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile card – tall, ~30% width
              Expanded(
                flex: 30,
                child: _AnimatedBentoCard(
                  delay: Duration.zero,
                  child: _ProfileCard(),
                ),
              ),
              const SizedBox(width: gap),
              // Headline card – ~40% width
              Expanded(
                flex: 40,
                child: _AnimatedBentoCard(
                  delay: animDur,
                  child: _HeadlineCard(
                    onExploreProjects: onExploreProjects,
                  ),
                ),
              ),
              const SizedBox(width: gap),
              // Right column: dark mode + stats
              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    _AnimatedBentoCard(
                      delay: animDur * 2,
                      child: const _DarkModeCard(),
                    ),
                    const SizedBox(height: gap),
                    _AnimatedBentoCard(
                      delay: animDur * 3,
                      child: const _StatsCard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: gap),

        // ── Row 2: Tech Stack (full width) ─────────────────────────
        _AnimatedBentoCard(
          delay: animDur * 4,
          child: const _TechStackCard(),
        ),

        const SizedBox(height: gap),

        // ── Row 3: CTA + GitHub ────────────────────────────────────
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 55,
                child: _AnimatedBentoCard(
                  delay: animDur * 5,
                  child: _CTACard(onContactMe: onContactMe),
                ),
              ),
              const SizedBox(width: gap),
              Expanded(
                flex: 45,
                child: _AnimatedBentoCard(
                  delay: animDur * 6,
                  child: const _GitHubCard(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Mobile Bento Layout (< 768 px)
// ─────────────────────────────────────────────
class _MobileBentoLayout extends StatelessWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onContactMe;

  const _MobileBentoLayout({
    required this.onExploreProjects,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 14);
    const animDur = Duration(milliseconds: 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AnimatedBentoCard(delay: Duration.zero, child: _ProfileCard()),
        gap,
        _AnimatedBentoCard(
          delay: animDur,
          child: _HeadlineCard(onExploreProjects: onExploreProjects),
        ),
        gap,
        _AnimatedBentoCard(
          delay: animDur * 2,
          child: const _DarkModeCard(),
        ),
        gap,
        _AnimatedBentoCard(
          delay: animDur * 3,
          child: const _StatsCard(),
        ),
        gap,
        _AnimatedBentoCard(
          delay: animDur * 4,
          child: const _TechStackCard(),
        ),
        gap,
        _AnimatedBentoCard(
          delay: animDur * 5,
          child: _CTACard(onContactMe: onContactMe),
        ),
        gap,
        _AnimatedBentoCard(
          delay: animDur * 6,
          child: const _GitHubCard(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Entrance-animated bento card wrapper
// ─────────────────────────────────────────────
class _AnimatedBentoCard extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedBentoCard({required this.child, required this.delay});

  @override
  State<_AnimatedBentoCard> createState() => _AnimatedBentoCardState();
}

class _AnimatedBentoCardState extends State<_AnimatedBentoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ─────────────────────────────────────────────
// Card: Profile
// ─────────────────────────────────────────────
class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BentoCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with gradient border
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3B82F6),
                  Color(0xFF6366F1),
                  Color(0xFF06B6D4)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(3),
            child: ClipOval(
              child: Image.asset(
                AppConstants.profileImagePath,
                width: 106,
                height: 106,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color:
                      isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 52,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            AppConstants.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Flutter Developer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          // Available badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.accentGreen.withValues(alpha: 0.35),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 8, color: AppColors.accentGreen),
                SizedBox(width: 6),
                Text(
                  'Available',
                  style: TextStyle(
                    color: AppColors.accentGreen,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Card: Headline
// ─────────────────────────────────────────────
class _HeadlineCard extends StatelessWidget {
  final VoidCallback onExploreProjects;

  const _HeadlineCard({required this.onExploreProjects});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Building Reliable,\nScalable Mobile\nExperiences.',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.8,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Flutter · Dart · BLoC · Clean Architecture',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 20),
          GradientButton(
            label: 'Explore Projects',
            icon: Icons.rocket_launch_rounded,
            onPressed: onExploreProjects,
            height: 44,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Card: Dark Mode Toggle
// ─────────────────────────────────────────────
class _DarkModeCard extends StatelessWidget {
  const _DarkModeCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

        return BentoCard(
          onTap: () => context.read<ThemeBloc>().add(const ThemeToggled()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isDark ? 'Dark Mode' : 'Light Mode',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isDark ? 'Switch to light' : 'Switch to dark',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 48,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: isDark
                      ? AppColors.primary
                      : Colors.grey.withValues(alpha: 0.35),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  alignment:
                      isDark ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 14,
                      color: isDark ? AppColors.primary : Colors.amber,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Card: Stats
// ─────────────────────────────────────────────
class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BentoCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(value: '3+', label: 'Years\nExp', isDark: isDark),
          _Divider(isDark: isDark),
          _StatItem(value: '5+', label: 'Apps\nBuilt', isDark: isDark),
          _Divider(isDark: isDark),
          _StatItem(value: '10+', label: 'Tech-\nnologies', isDark: isDark),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;

  const _StatItem(
      {required this.value, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.3,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: isDark
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.08),
    );
  }
}

// ─────────────────────────────────────────────
// Card: Tech Stack
// ─────────────────────────────────────────────
class _TechStackCard extends StatelessWidget {
  const _TechStackCard();

  static const _techs = [
    ('Flutter', Icons.flutter_dash_rounded, Color(0xFF54C5F8)),
    ('Dart', Icons.code_rounded, Color(0xFF3B82F6)),
    ('BLoC', Icons.hub_rounded, Color(0xFF8B5CF6)),
    ('Clean Arch', Icons.layers_rounded, Color(0xFF6366F1)),
    ('REST APIs', Icons.cloud_sync_rounded, Color(0xFF10B981)),
    ('Firebase', Icons.local_fire_department_rounded, Color(0xFFFF7043)),
    ('Hive', Icons.storage_rounded, Color(0xFFF59E0B)),
    ('go_router', Icons.alt_route_rounded, Color(0xFFEC4899)),
    ('Git', Icons.merge_type_rounded, Color(0xFFF97316)),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BentoCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tech Stack',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _techs.map((t) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _TechChip(
                    label: t.$1,
                    icon: t.$2,
                    color: t.$3,
                    isDark: isDark,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _TechChip(
      {required this.label,
      required this.icon,
      required this.color,
      required this.isDark});

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withValues(alpha: widget.isDark ? 0.25 : 0.15)
              : (widget.isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.04)),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.5)
                : (widget.isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.08)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 15, color: widget.color),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: widget.isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Card: CTA
// ─────────────────────────────────────────────
class _CTACard extends StatelessWidget {
  final VoidCallback onContactMe;
  const _CTACard({required this.onContactMe});

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Let's Work\nTogether",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Open for Flutter &\nMobile roles',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: onContactMe,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Contact Me',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.handshake_rounded,
            size: 64,
            color: Colors.white24,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Card: GitHub
// ─────────────────────────────────────────────
class _GitHubCard extends StatelessWidget {
  const _GitHubCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BentoCard(
      onTap: () => UrlHelper.launchExternal(AppConstants.githubUrl),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              FontAwesomeIcons.github,
              size: 28,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'GitHub',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'github.com/sudalai007',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'View Profile →',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
