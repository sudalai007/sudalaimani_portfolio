import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/projects_repository.dart';
import '../datasources/projects_local_data_source.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsLocalDataSource _localDataSource;

  ProjectsRepositoryImpl({required ProjectsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<List<ProjectEntity>> getProjects() async {
    final models = _localDataSource.getProjects();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ProjectEntity?> getProjectBySlug(String slug) async {
    final projects = await getProjects();
    try {
      return projects.firstWhere((p) => p.slug == slug);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<String>> getCategories() async {
    final projects = await getProjects();
    final categories = <String>{'All Projects'};
    for (final p in projects) {
      categories.add(p.category);
    }
    return categories.toList();
  }
}

