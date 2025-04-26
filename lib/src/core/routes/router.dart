// ignore_for_file: avoid_print

part of 'import.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GlobalKey<NavigatorState> mainMenuNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'main_menu');

  static final GoRouter router = GoRouter(
    errorPageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: const PageNotFoundScreen()),
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutesName.frontCover,
    // debugLogDiagnostics: true,
    // observers: [MyNavigatorObserver()],
    // overridePlatformDefaultLocation: true, // it is for web

    routes: [
      GoRoute(
        path: RoutesName.pageNotFound,
        name: RoutesName.pageNotFound,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: const PageNotFoundScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: RoutesName.frontCover,
        name: RoutesName.frontCover,
        pageBuilder: (_, state) {
          return _buildTransition(
            child: BlocProvider<DocumentCubit>(
              create: (BuildContext context) => sl<DocumentCubit>(),
              child: const FrontCover(),
            ),
            state: state,
          );
        },
        routes: [
          GoRoute(
            path: RoutesName.backCover,
            name: RoutesName.backCover,
            pageBuilder: (_, state) {
              return _buildTransition(
                child: BlocProvider<DocumentCubit>.value(
                  value: sl<DocumentCubit>(),
                  child: const BackCover(),
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            path: RoutesName.adhaarBuildPage,
            name: RoutesName.adhaarBuildPage,
            pageBuilder: (_, state) {
              return _buildTransition(
                child: BlocProvider<DocumentCubit>.value(
                  value: sl<DocumentCubit>(),
                  child: const AdhaarBuildPage(),
                ),
                state: state,
              );
            },
          ),
        ],
      ),
    ],
  );

  static Page<void> _buildTransition({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: kThemeAnimationDuration,
      reverseTransitionDuration: kThemeAnimationDuration,
    );
  }
}

// Custom NavigatorObserver
class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Pushed a new route: ${route.settings.name}');

    // Add your analytics tracking or other logic here
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('Popped a route: ${route.settings.name}');
    }
    // Add any logic you need for route popping
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Removed a route: ${route.settings.name}');
    // Manage resources associated with the route
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('Replaced route: ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
    // Track route replacement, e.g., during authentication flow
  }

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    print(
      'Top route changed from ${previousTopRoute?.settings.name} to ${topRoute.settings.name}',
    );
    // General monitoring of screen transitions
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Started user gesture on route: ${route.settings.name}');
    // Pause animations or media playback
  }

  @override
  void didStopUserGesture() {
    print('Stopped user gesture');
    // Resume animations or media playback
  }
}
