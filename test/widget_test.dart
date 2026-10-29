import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudalaimani_portfolio/core/constants/app_constants.dart';
import 'package:sudalaimani_portfolio/core/constants/app_strings.dart';
import 'package:sudalaimani_portfolio/core/theme/app_theme.dart';
import 'package:sudalaimani_portfolio/core/theme/bloc/theme_bloc.dart';
import 'package:sudalaimani_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:sudalaimani_portfolio/features/home/presentation/widgets/projects_section.dart';
import 'package:sudalaimani_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:sudalaimani_portfolio/features/projects/data/repositories/projects_repository_impl.dart';
import 'package:sudalaimani_portfolio/features/projects/domain/entities/project_entity.dart';
import 'package:sudalaimani_portfolio/features/projects/presentation/bloc/project_filter_bloc.dart';
import 'package:sudalaimani_portfolio/features/projects/presentation/widgets/project_card.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Widget Tests', () {
    testWidgets('HeroSection renders full name, title, and CTA buttons',
        (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool explored = false;
      bool contacted = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: HeroSection(
                onExploreProjects: () => explored = true,
                onContactMe: () => contacted = true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check name and professional title
      expect(find.text(AppConstants.fullName), findsOneWidget);
      expect(find.text(AppConstants.professionalTitle), findsOneWidget);

      // Check headline and subheadline
      expect(find.text(AppStrings.heroHeadline), findsOneWidget);
      expect(find.text(AppStrings.heroSubheadline), findsOneWidget);

      // Check CTA buttons
      expect(find.text(AppStrings.heroCtaProjects), findsOneWidget);
      expect(find.text(AppStrings.heroCtaContact), findsOneWidget);

      // Tap buttons and verify callbacks
      await tester.tap(find.text(AppStrings.heroCtaProjects));
      expect(explored, isTrue);

      await tester.tap(find.text(AppStrings.heroCtaContact));
      expect(contacted, isTrue);
    });

    testWidgets('ProjectCard displays title, description, and Play Store button',
        (tester) async {
      tester.view.physicalSize = const Size(800, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      bool detailsTapped = false;
      const testProject = ProjectEntity(
        id: '1',
        title: 'Selco Foundation',
        slug: 'selco-foundation',
        description: 'Survey application supporting field data collection.',
        fullDescription: 'Full description for testing.',
        category: 'Field Operations',
        technologies: ['Flutter', 'Dart', 'REST APIs', 'SQLite'],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.selcofoundation&hl=en_IN',
        githubUrl: null,
        localScreenshotAsset: null,
        iconData: Icons.fact_check_rounded,
        gradientColors: [Color(0xFF0D9488), Color(0xFF14B8A6)],
        highlights: ['Offline-first architecture'],
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 380,
                height: 520,
                child: ProjectCard(
                  project: testProject,
                  onDetailsTap: () => detailsTapped = true,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify title and description
      expect(find.text('Selco Foundation'), findsOneWidget);
      expect(find.text(testProject.description), findsOneWidget);
      expect(
        find.byWidgetPredicate((w) => w is ElevatedButton),
        findsOneWidget,
      );
      expect(find.widgetWithText(OutlinedButton, 'Details'), findsOneWidget);

      // Tap details button
      await tester.tap(find.widgetWithText(OutlinedButton, 'Details'));
      expect(detailsTapped, isTrue);
    });

    testWidgets(
        'ProjectsSection renders without overflow on small and reduced screen sizes',
        (tester) async {
      // Small screen test (360x640 - typical compact mobile phone)
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final repository = ProjectsRepositoryImpl(
        localDataSource: ProjectsLocalDataSourceImpl(),
      );
      final projectFilterBloc = ProjectFilterBloc(projectsRepository: repository);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: SingleChildScrollView(
              child: BlocProvider<ProjectFilterBloc>.value(
                value: projectFilterBloc,
                child: const ProjectsSection(),
              ),
            ),
          ),
        ),
      );

      // Wait for projects to load and settle
      await tester.pumpAndSettle();

      // Check that projects are displayed without overflow errors
      expect(find.text('Selco Foundation'), findsOneWidget);
      expect(find.text('Go1 HelpDesk'), findsOneWidget);

      // Now dynamically resize to intermediate tablet width (768x1024)
      tester.view.physicalSize = const Size(768, 1024);
      await tester.pumpAndSettle();

      expect(find.text('Selco Foundation'), findsOneWidget);
      expect(find.text('Torque Partner'), findsOneWidget);

      projectFilterBloc.close();
    });

    testWidgets('ThemeBloc adapts theme between light and dark',
        (tester) async {
      final prefs = await SharedPreferences.getInstance();
      final themeBloc = ThemeBloc(prefs: prefs);

      await tester.pumpWidget(
        BlocProvider<ThemeBloc>.value(
          value: themeBloc,
          child: BlocBuilder<ThemeBloc, dynamic>(
            builder: (context, state) {
              return MaterialApp(
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeBloc.state.themeMode,
                home: Scaffold(
                  body: Center(
                    child: Text(
                      themeBloc.state.isDarkMode ? 'DarkActive' : 'LightActive',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('DarkActive'), findsOneWidget);

      themeBloc.close();
    });
  });
}
