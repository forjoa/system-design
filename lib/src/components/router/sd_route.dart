import 'package:flutter/widgets.dart';

import 'sd_page_transition.dart';

/// Arguments passed to a route's builder function.
class SdRouteArgs {
  const SdRouteArgs({
    this.pathParams = const {},
    this.queryParams = const {},
    this.extra,
  });

  /// Extracted path parameters, e.g. `/users/:id` → `{'id': '123'}`.
  final Map<String, String> pathParams;

  /// Query string parameters, e.g. `?tab=profile` → `{'tab': 'profile'}`.
  final Map<String, String> queryParams;

  /// Arbitrary extra data passed programmatically via [SdRouterDelegate.go].
  final Object? extra;
}

/// Defines a single navigable location.
///
/// ```dart
/// SdRoute(
///   path: '/profile/:id',
///   builder: (context, args) => ProfilePage(id: args.pathParams['id']!),
/// )
/// ```
class SdRoute {
  const SdRoute({
    required this.path,
    required this.builder,
    this.name,
    this.transition = SdPageTransition.fade,
    this.redirectIf,
    this.redirectTo,
  }) : assert(
          redirectIf == null || redirectTo != null,
          'redirectTo must be provided when redirectIf is set',
        );

  /// URL pattern. Supports path parameters prefixed with `:`, e.g. `/users/:id`.
  final String path;

  /// Builds the page widget for this route.
  final Widget Function(BuildContext context, SdRouteArgs args) builder;

  /// Optional human-readable name for debugging and deep links.
  final String? name;

  final SdPageTransition transition;

  /// When this returns `true`, the router redirects to [redirectTo].
  final bool Function(SdRouteArgs args)? redirectIf;

  /// Target path for redirect when [redirectIf] is `true`.
  final String? redirectTo;
}

/// A route that renders a persistent shell widget around its child route.
///
/// Useful for layouts with a persistent bottom navigation bar or sidebar.
///
/// ```dart
/// SdShellRoute(
///   path: '/',
///   shell: (context, child) => AppShell(body: child),
///   routes: [
///     SdRoute(path: '/home', builder: (_, __) => HomePage()),
///     SdRoute(path: '/settings', builder: (_, __) => SettingsPage()),
///   ],
/// )
/// ```
class SdShellRoute extends SdRoute {
  SdShellRoute({
    required super.path,
    required this.shell,
    required this.routes,
    super.transition,
  }) : super(
          builder: (_, _) => const SizedBox.shrink(),
        );

  /// Wraps the matched child route widget.
  final Widget Function(BuildContext context, Widget child) shell;

  /// Child routes rendered inside [shell].
  final List<SdRoute> routes;
}
