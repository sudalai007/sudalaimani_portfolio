import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProjectEntity extends Equatable {
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

  const ProjectEntity({
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

  bool get hasGithub => githubUrl != null && githubUrl!.isNotEmpty;
  bool get hasLocalScreenshot =>
      localScreenshotAsset != null && localScreenshotAsset!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
        description,
        fullDescription,
        category,
        technologies,
        playStoreUrl,
        githubUrl,
        localScreenshotAsset,
        iconData,
        gradientColors,
        highlights,
      ];
}

