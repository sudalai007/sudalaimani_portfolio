import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/not_found/presentation/pages/not_found_page.dart';
import '../../features/project_detail/presentation/pages/project_detail_page.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: RouteNames.projects,
        path: '/projects',
        builder: (context, state) => const HomePage(initialSection: 'projects'),
      ),
      GoRoute(
        name: RouteNames.projectDetail,
        path: '/projects/:slug',
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return ProjectDetailPage(slug: slug);
        },
      ),
      GoRoute(
        name: RouteNames.contact,
        path: '/contact',
        builder: (context, state) => const HomePage(initialSection: 'contact'),
      ),
    ],
  );
}
