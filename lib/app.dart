import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'core/theme/bloc/theme_state.dart';
import 'di/service_locator.dart';
import 'features/contact/presentation/bloc/contact_bloc.dart';
import 'features/projects/presentation/bloc/project_filter_bloc.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>()),
        BlocProvider<ProjectFilterBloc>(create: (_) => sl<ProjectFilterBloc>()),
        BlocProvider<ContactBloc>(create: (_) => sl<ContactBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: '${AppConstants.fullName} | ${AppConstants.professionalTitle}',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

