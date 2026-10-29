import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/theme/bloc/theme_bloc.dart';
import '../features/contact/presentation/bloc/contact_bloc.dart';
import '../features/projects/data/datasources/projects_local_data_source.dart';
import '../features/projects/data/repositories/projects_repository_impl.dart';
import '../features/projects/domain/repositories/projects_repository.dart';
import '../features/projects/presentation/bloc/project_filter_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Projects Data Source & Repository
  sl.registerLazySingleton<ProjectsLocalDataSource>(
    () => ProjectsLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ProjectsRepository>(
    () => ProjectsRepositoryImpl(localDataSource: sl()),
  );

  // BLoCs
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(prefs: sl()));
  sl.registerFactory<ProjectFilterBloc>(
    () => ProjectFilterBloc(projectsRepository: sl()),
  );
  sl.registerFactory<ContactBloc>(() => ContactBloc());
}

