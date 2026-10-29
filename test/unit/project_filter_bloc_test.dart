import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudalaimani_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:sudalaimani_portfolio/features/projects/data/repositories/projects_repository_impl.dart';
import 'package:sudalaimani_portfolio/features/projects/presentation/bloc/project_filter_bloc.dart';
import 'package:sudalaimani_portfolio/features/projects/presentation/bloc/project_filter_event.dart';
import 'package:sudalaimani_portfolio/features/projects/presentation/bloc/project_filter_state.dart';

void main() {
  group('ProjectFilterBloc Tests', () {
    late ProjectsRepositoryImpl repository;

    setUp(() {
      repository = ProjectsRepositoryImpl(
        localDataSource: ProjectsLocalDataSourceImpl(),
      );
    });

    test('initial state has ProjectStatus.initial or starts loading', () async {
      final bloc = ProjectFilterBloc(projectsRepository: repository);
      final loadedState = await bloc.stream
          .firstWhere((s) => s.status == ProjectStatus.loaded);
      expect(loadedState.allProjects.length, 5);
      expect(loadedState.filteredProjects.length, 5);
      await bloc.close();
    });

    blocTest<ProjectFilterBloc, ProjectFilterState>(
      'CategorySelected filters correctly',
      build: () => ProjectFilterBloc(projectsRepository: repository),
      setUp: () async {
        // give time for constructor's LoadProjectsRequested to finish
      },
      act: (bloc) async {
        await bloc.stream.firstWhere((s) => s.status == ProjectStatus.loaded);
        bloc.add(const CategorySelected('Field Operations'));
      },
      verify: (bloc) {
        expect(bloc.state.selectedCategory, 'Field Operations');
        expect(bloc.state.filteredProjects.length, 1);
        expect(bloc.state.filteredProjects.first.title, 'Selco Foundation');
      },
    );

    blocTest<ProjectFilterBloc, ProjectFilterState>(
      'SearchQueryChanged filters correctly',
      build: () => ProjectFilterBloc(projectsRepository: repository),
      act: (bloc) async {
        await bloc.stream.firstWhere((s) => s.status == ProjectStatus.loaded);
        bloc.add(const SearchQueryChanged('driver'));
      },
      verify: (bloc) {
        expect(bloc.state.searchQuery, 'driver');
        expect(bloc.state.filteredProjects.length, 1);
        expect(bloc.state.filteredProjects.first.title, 'Redsun Travel Driver');
      },
    );
  });
}

