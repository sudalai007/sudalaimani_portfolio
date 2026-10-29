import 'package:equatable/equatable.dart';

abstract class ProjectFilterEvent extends Equatable {
  const ProjectFilterEvent();

  @override
  List<Object?> get props => [];
}

class LoadProjectsRequested extends ProjectFilterEvent {
  const LoadProjectsRequested();
}

class CategorySelected extends ProjectFilterEvent {
  final String category;

  const CategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}

class SearchQueryChanged extends ProjectFilterEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

