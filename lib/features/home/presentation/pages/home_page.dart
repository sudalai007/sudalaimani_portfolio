import 'package:flutter/material.dart';
import '../widgets/about_section.dart';
import '../widgets/background_mesh.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';

class HomePage extends StatefulWidget {
  final String? initialSection;

  const HomePage({super.key, this.initialSection});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  int _activeNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    if (widget.initialSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleInitialSection(widget.initialSection!);
      });
    }
  }

  void _handleInitialSection(String section) {
    switch (section.toLowerCase()) {
      case 'about':
        _scrollToSection(1);
        break;
      case 'skills':
        _scrollToSection(2);
        break;
      case 'projects':
        _scrollToSection(3);
        break;
      case 'experience':
        _scrollToSection(4);
        break;
      case 'contact':
        _scrollToSection(5);
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    int index = 0;

    if (offset < 400) {
      index = 0;
    } else if (offset < 1100) {
      index = 1;
    } else if (offset < 1900) {
      index = 2;
    } else if (offset < 2800) {
      index = 3;
    } else if (offset < 3600) {
      index = 4;
    } else {
      index = 5;
    }

    if (index != _activeNavIndex && mounted) {
      setState(() => _activeNavIndex = index);
    }
  }

  void _scrollToSection(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _skillsKey;
        break;
      case 3:
        targetKey = _projectsKey;
        break;
      case 4:
        targetKey = _experienceKey;
        break;
      case 5:
        targetKey = _contactKey;
        break;
      default:
        targetKey = _heroKey;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MobileDrawer(
        activeIndex: _activeNavIndex,
        onSectionSelected: _scrollToSection,
      ),
      body: BackgroundMesh(
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 72), // Offset for sticky navbar
                    HeroSection(
                      key: _heroKey,
                      onExploreProjects: () => _scrollToSection(3),
                      onContactMe: () => _scrollToSection(5),
                    ),
                    AboutSection(key: _aboutKey),
                    SkillsSection(key: _skillsKey),
                    ProjectsSection(key: _projectsKey),
                    ExperienceSection(key: _experienceKey),
                    ContactSection(key: _contactKey),
                    FooterSection(onSectionSelected: _scrollToSection),
                  ],
                ),
              ),
            ),

            // Sticky Navigation Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavigationBarWidget(
                activeIndex: _activeNavIndex,
                onSectionSelected: _scrollToSection,
                onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

