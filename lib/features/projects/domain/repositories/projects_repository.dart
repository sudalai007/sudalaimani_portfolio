import '../entities/project_entity.dart';

abstract class ProjectsRepository {
  Future<List<ProjectEntity>> getProjects();
  Future<ProjectEntity?> getProjectBySlug(String slug);
  Future<List<String>> getCategories();
}

