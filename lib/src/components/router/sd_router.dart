import 'package:flutter/material.dart';

import 'sd_page_transition.dart';
import 'sd_route.dart';

export 'sd_page_transition.dart';
export 'sd_route.dart';

// ---------------------------------------------------------------------------
// URI model
// ---------------------------------------------------------------------------

/// Parsed representation of a URL used by the router internals.
class SdRouteUri {
  const SdRouteUri({
    required this.path,
    this.queryParams = const {},
    this.extra,
  });

  final String path;
  final Map<String, String> queryParams;
  final Object? extra;

  @override
  String toString() {
    if (queryParams.isEmpty) return path;
    final q = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$path?$q';
  }
}

// ---------------------------------------------------------------------------
// RouteInformationParser
// ---------------------------------------------------------------------------

class _SdRouteInformationParser extends RouteInformationParser<SdRouteUri> {
  @override
  Future<SdRouteUri> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;
    return SdRouteUri(
      path: uri.path.isEmpty ? '/' : uri.path,
      queryParams: Map<String, String>.from(uri.queryParameters),
    );
  }

  @override
  RouteInformation restoreRouteInformation(SdRouteUri configuration) {
    return RouteInformation(uri: Uri.parse(configuration.toString()));
  }
}

// ---------------------------------------------------------------------------
// RouterDelegate
// ---------------------------------------------------------------------------

/// The Navigator 2.0 delegate powering [SdRouterConfig].
///
/// Access via `context.sdRouter` to push, pop, or replace routes
/// programmatically.
class SdRouterDelegate extends RouterDelegate<SdRouteUri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SdRouteUri> {
  SdRouterDelegate({
    required this.routes,
    required this.initialLocation,
    this.errorBuilder,
    this.onNavigate,
    this.observers,
  }) {
    _stack = [SdRouteUri(path: initialLocation)];
  }

  final List<SdRoute> routes;
  final String initialLocation;
  final Widget Function(BuildContext context, String path)? errorBuilder;
  final void Function(String location, SdRouteArgs args)? onNavigate;
  final List<NavigatorObserver>? observers;

  late List<SdRouteUri> _stack;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // ---------------------------------------------------------------------------
  // Public navigation API
  // ---------------------------------------------------------------------------

  /// Current location string.
  String get location => _stack.last.path;

  /// Push a new location onto the stack.
  void push(String path, {Map<String, String>? queryParams, Object? extra}) {
    _stack.add(SdRouteUri(
      path: path,
      queryParams: queryParams ?? const {},
      extra: extra,
    ));
    notifyListeners();
  }

  /// Replace the current location (clears stack to root + new path).
  void go(String path, {Map<String, String>? queryParams, Object? extra}) {
    _stack = [
      SdRouteUri(
        path: path,
        queryParams: queryParams ?? const {},
        extra: extra,
      ),
    ];
    notifyListeners();
  }

  /// Pop the current location. Does nothing if already at the root.
  void pop() {
    if (_stack.length > 1) {
      _stack.removeLast();
      notifyListeners();
    }
  }

  bool get canPop => _stack.length > 1;

  // ---------------------------------------------------------------------------
  // RouterDelegate contract
  // ---------------------------------------------------------------------------

  @override
  SdRouteUri get currentConfiguration => _stack.last;

  @override
  Future<void> setNewRoutePath(SdRouteUri configuration) async {
    final resolved = _resolveRedirect(configuration);
    _stack = [resolved];
  }

  SdRouteUri _resolveRedirect(SdRouteUri uri) {
    final route = _matchRoute(uri.path, routes);
    if (route == null) return uri;
    final args = _buildArgs(uri, route);
    if (route.redirectIf != null && route.redirectIf!(args)) {
      return SdRouteUri(path: route.redirectTo!);
    }
    return uri;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _stack.map((uri) => _buildPage(context, uri)).toList();

    return Navigator(
      key: navigatorKey,
      observers: observers ?? const [],
      pages: pages,
      onDidRemovePage: (_) {
        if (_stack.length > 1) {
          _stack.removeLast();
          notifyListeners();
        }
      },
    );
  }

  Page<dynamic> _buildPage(BuildContext context, SdRouteUri uri) {
    final route = _matchRoute(uri.path, routes);

    if (route == null) {
      final errorWidget = errorBuilder?.call(context, uri.path) ??
          _DefaultErrorPage(path: uri.path);
      return SdTransitionPage(
        key: ValueKey(uri.toString()),
        name: uri.path,
        child: errorWidget,
      );
    }

    final args = _buildArgs(uri, route);
    onNavigate?.call(uri.path, args);

    // Shell route: find the matching child and wrap it in the shell.
    if (route is SdShellRoute) {
      final childUri = _stack.length > 1 ? _stack.last : uri;
      final childRoute = _matchRoute(childUri.path, route.routes);
      final childArgs =
          childRoute != null ? _buildArgs(childUri, childRoute) : args;
      final childWidget = childRoute?.builder(context, childArgs) ??
          (errorBuilder?.call(context, childUri.path) ??
              _DefaultErrorPage(path: childUri.path));
      return SdTransitionPage(
        key: ValueKey(uri.toString()),
        name: uri.path,
        transition: route.transition,
        child: route.shell(context, childWidget),
      );
    }

    return SdTransitionPage(
      key: ValueKey(uri.toString()),
      name: uri.path,
      transition: route.transition,
      child: route.builder(context, args),
    );
  }

  // ---------------------------------------------------------------------------
  // Path matching helpers
  // ---------------------------------------------------------------------------

  static SdRoute? _matchRoute(String path, List<SdRoute> routes) {
    for (final route in routes) {
      if (_pathMatches(path, route.path)) return route;
      if (route is SdShellRoute) {
        final child = _matchRoute(path, route.routes);
        if (child != null) return route;
      }
    }
    return null;
  }

  static bool _pathMatches(String path, String pattern) {
    final patternSegments = pattern.split('/');
    final pathSegments = path.split('/');
    if (patternSegments.length != pathSegments.length) return false;
    for (int i = 0; i < patternSegments.length; i++) {
      if (patternSegments[i].startsWith(':')) continue;
      if (patternSegments[i] != pathSegments[i]) return false;
    }
    return true;
  }

  static Map<String, String> _extractPathParams(
    String path,
    String pattern,
  ) {
    final params = <String, String>{};
    final patternSegments = pattern.split('/');
    final pathSegments = path.split('/');
    for (int i = 0; i < patternSegments.length; i++) {
      if (patternSegments[i].startsWith(':')) {
        params[patternSegments[i].substring(1)] = pathSegments[i];
      }
    }
    return params;
  }

  static SdRouteArgs _buildArgs(SdRouteUri uri, SdRoute route) {
    return SdRouteArgs(
      pathParams: _extractPathParams(uri.path, route.path),
      queryParams: uri.queryParams,
      extra: uri.extra,
    );
  }
}

// ---------------------------------------------------------------------------
// RouterConfig builder
// ---------------------------------------------------------------------------

/// Builds a [RouterConfig] for use with [MaterialApp.router].
///
/// ```dart
/// MaterialApp.router(
///   routerConfig: SdRouterConfig(
///     routes: [
///       SdRoute(path: '/', builder: (_, __) => HomePage()),
///       SdRoute(path: '/about', builder: (_, __) => AboutPage()),
///     ],
///   ).build(),
/// )
/// ```
class SdRouterConfig {
  SdRouterConfig({
    required this.routes,
    this.initialLocation = '/',
    this.errorBuilder,
    this.onNavigate,
    this.observers,
  });

  final List<SdRoute> routes;
  final String initialLocation;
  final Widget Function(BuildContext context, String path)? errorBuilder;
  final void Function(String location, SdRouteArgs args)? onNavigate;
  final List<NavigatorObserver>? observers;

  /// Produces the [RouterConfig] to pass to [MaterialApp.router].
  RouterConfig<SdRouteUri> build() {
    final delegate = SdRouterDelegate(
      routes: routes,
      initialLocation: initialLocation,
      errorBuilder: errorBuilder,
      onNavigate: onNavigate,
      observers: observers,
    );
    return RouterConfig(
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(
          uri: Uri.parse(initialLocation),
        ),
      ),
      routeInformationParser: _SdRouteInformationParser(),
      routerDelegate: delegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}

// ---------------------------------------------------------------------------
// Default error page
// ---------------------------------------------------------------------------

class _DefaultErrorPage extends StatelessWidget {
  const _DefaultErrorPage({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No route found for "$path"',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BuildContext extension
// ---------------------------------------------------------------------------

extension SdRouterContext on BuildContext {
  /// The nearest [SdRouterDelegate] for programmatic navigation.
  SdRouterDelegate get sdRouter {
    final delegate = Router.of(this).routerDelegate;
    assert(
      delegate is SdRouterDelegate,
      'context.sdRouter requires SdRouterConfig to be used with MaterialApp.router.',
    );
    return delegate as SdRouterDelegate;
  }
}
