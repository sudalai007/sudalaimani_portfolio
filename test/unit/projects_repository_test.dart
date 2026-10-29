import 'package:flutter_test/flutter_test.dart';
import 'package:sudalaimani_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:sudalaimani_portfolio/features/projects/data/repositories/projects_repository_impl.dart';

void main() {
  group('ProjectsRepository Tests', () {
    late ProjectsLocalDataSource localDataSource;
    late ProjectsRepositoryImpl repository;

    setUp(() {
      localDataSource = ProjectsLocalDataSourceImpl();
      repository = ProjectsRepositoryImpl(localDataSource: localDataSource);
    });

    test('getProjects returns all 5 verified production projects', () async {
      final projects = await repository.getProjects();
      expect(projects.length, 5);

      final titles = projects.map((p) => p.title).toList();
      expect(titles, contains('Selco Foundation'));
      expect(titles, contains('Go1 HelpDesk'));
      expect(titles, contains('Torque Partner'));
      expect(titles, contains('Redsun Travel Driver'));
      expect(titles, contains('Orbee Insurance'));
    });

    test('All project Play Store URLs are valid and present', () async {
      final projects = await repository.getProjects();
      for (final project in projects) {
        expect(project.playStoreUrl, isNotEmpty);
        expect(
          project.playStoreUrl.startsWith('https://play.google.com/store/'),
          isTrue,
        );
      }
    });

    test('getProjectBySlug retrieves project successfully', () async {
      final selco = await repository.getProjectBySlug('selco-foundation');
      expect(selco, isNotNull);
      expect(selco!.title, 'Selco Foundation');
      expect(
        selco.playStoreUrl,
        'https://play.google.com/store/apps/details?id=com.selcofoundation&hl=en_IN',
      );

      final nonExistent = await repository.getProjectBySlug('unknown-app');
      expect(nonExistent, isNull);
    });

    test('getCategories contains All Projects and specific categories', () async {
      final categories = await repository.getCategories();
      expect(categories, contains('All Projects'));
      expect(categories, contains('Field Operations'));
      expect(categories, contains('Productivity & Support'));
      expect(categories, contains('Logistics & Travel'));
      expect(categories, contains('Fintech & Insurance'));
    });
  });
}

