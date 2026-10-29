import 'package:equatable/equatable.dart';
import '../../domain/entities/project_entity.dart';

enum ProjectStatus { initial, loading, loaded, error }

class ProjectFilterState extends Equatable {
  final ProjectStatus status;
  final List<ProjectEntity> allProjects;
  final List<ProjectEntity> filteredProjects;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;
  final String? errorMessage;

  const ProjectFilterState({
    this.status = ProjectStatus.initial,
    this.allProjects = const [],
    this.filteredProjects = const [],
    this.categories = const ['All Projects'],
    this.selectedCategory = 'All Projects',
    this.searchQuery = '',
    this.errorMessage,
  });

  ProjectFilterState copyWith({
    ProjectStatus? status,
    List<ProjectEntity>? allProjects,
    List<ProjectEntity>? filteredProjects,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ProjectFilterState(
      status: status ?? this.status,
      allProjects: allProjects ?? this.allProjects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allProjects,
        filteredProjects,
        categories,
        selectedCategory,
        searchQuery,
        errorMessage,
      ];
}

