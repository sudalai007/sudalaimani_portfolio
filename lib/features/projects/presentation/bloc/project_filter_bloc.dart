import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/projects_repository.dart';
import 'project_filter_event.dart';
import 'project_filter_state.dart';

class ProjectFilterBloc extends Bloc<ProjectFilterEvent, ProjectFilterState> {
  final ProjectsRepository _projectsRepository;

  ProjectFilterBloc({required ProjectsRepository projectsRepository})
      : _projectsRepository = projectsRepository,
        super(const ProjectFilterState()) {
    on<LoadProjectsRequested>(_onLoadProjectsRequested);
    on<CategorySelected>(_onCategorySelected);
    on<SearchQueryChanged>(_onSearchQueryChanged);

    add(const LoadProjectsRequested());
  }

  Future<void> _onLoadProjectsRequested(
    LoadProjectsRequested event,
    Emitter<ProjectFilterState> emit,
  ) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    try {
      final projects = await _projectsRepository.getProjects();
      final categories = await _projectsRepository.getCategories();
      emit(state.copyWith(
        status: ProjectStatus.loaded,
        allProjects: projects,
        filteredProjects: projects,
        categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProjectStatus.error,
        errorMessage: 'Failed to load projects: $e',
      ));
    }
  }

  void _onCategorySelected(
    CategorySelected event,
    Emitter<ProjectFilterState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
    _applyFilters(emit);
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ProjectFilterState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
    _applyFilters(emit);
  }

  void _applyFilters(Emitter<ProjectFilterState> emit) {
    List<ProjectEntity> results = List.from(state.allProjects);

    if (state.selectedCategory != 'All Projects') {
      results = results
          .where((p) => p.category == state.selectedCategory)
          .toList();
    }

    if (state.searchQuery.trim().isNotEmpty) {
      final query = state.searchQuery.toLowerCase().trim();
      results = results.where((p) {
        final matchesTitle = p.title.toLowerCase().contains(query);
        final matchesDesc = p.description.toLowerCase().contains(query);
        final matchesTech =
            p.technologies.any((t) => t.toLowerCase().contains(query));
        return matchesTitle || matchesDesc || matchesTech;
      }).toList();
    }

    emit(state.copyWith(filteredProjects: results));
  }
}

