import 'package:flutter/material.dart';
import '../../domain/entities/project_entity.dart';

class ProjectModel {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String fullDescription;
  final String category;
  final List<String> technologies;
  final String playStoreUrl;
  final String? githubUrl;
  final String? localScreenshotAsset;
  final IconData iconData;
  final List<Color> gradientColors;
  final List<String> highlights;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.fullDescription,
    required this.category,
    required this.technologies,
    required this.playStoreUrl,
    this.githubUrl,
    this.localScreenshotAsset,
    required this.iconData,
    required this.gradientColors,
    required this.highlights,
  });

  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      fullDescription: fullDescription,
      category: category,
      technologies: technologies,
      playStoreUrl: playStoreUrl,
      githubUrl: githubUrl,
      localScreenshotAsset: localScreenshotAsset,
      iconData: iconData,
      gradientColors: gradientColors,
      highlights: highlights,
    );
  }
}

