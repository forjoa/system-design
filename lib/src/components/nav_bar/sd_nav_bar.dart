import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import '../router/sd_router.dart';
import 'sd_nav_bar_style.dart';
import 'sd_nav_bar_theme.dart';

export 'sd_nav_bar_style.dart';
export 'sd_nav_bar_theme.dart';

// ---------------------------------------------------------------------------
// SdNavBarItem
// ---------------------------------------------------------------------------

/// A single entry in [SdNavBar].
///
/// ```dart
/// SdNavBarItem(
///   path: '/home',
///   icon: const Icon(Icons.home_outlined),
///   label: 'Home',
/// )
/// ```
class SdNavBarItem {
  const SdNavBarItem({
    required this.path,
    required this.icon,
    required this.label,
  });

  /// The route path this tab navigates to (e.g. `'/home'`).
  final String path;

  /// Icon widget rendered for this tab.
  final Widget icon;

  /// Text label rendered below the icon.
  final String label;
}

// ---------------------------------------------------------------------------
// SdNavBar
// ---------------------------------------------------------------------------

/// A floating, pill-shaped bottom navigation bar that integrates with
/// [SdRouterConfig].
///
/// Place it inside a [SdShellRoute]'s shell, typically as
/// `Scaffold.bottomNavigationBar`:
///
/// ```dart
/// SdShellRoute(
///   path: '/',
///   shell: (context, child) => Scaffold(
///     backgroundColor: context.sdTheme.colors.background,
///     extendBody: true,
///     body: child,
///     bottomNavigationBar: SdNavBar(
///       items: [
///         SdNavBarItem(path: '/home',    icon: const Icon(Icons.home_outlined),   label: 'Home'),
///         SdNavBarItem(path: '/search',  icon: const Icon(Icons.search),           label: 'Search'),
///         SdNavBarItem(path: '/profile', icon: const Icon(Icons.person_outlined),  label: 'Profile'),
///       ],
///     ),
///   ),
///   routes: [
///     SdRoute(path: '/home',    builder: (_, __) => const HomePage()),
///     SdRoute(path: '/search',  builder: (_, __) => const SearchPage()),
///     SdRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
///   ],
/// )
/// ```
class SdNavBar extends StatelessWidget {
  const SdNavBar({
    super.key,
    required this.items,
    this.style,
  }) : assert(items.length >= 2, 'SdNavBar requires at least 2 items.');

  /// The navigation tabs. Minimum 2, recommended 2–5.
  final List<SdNavBarItem> items;

  /// Per-instance style override. Non-null fields take precedence over [SdNavBarTheme].
  final SdNavBarStyle? style;

  bool _isActive(String location, String path) {
    if (path == '/') return location == '/';
    return location == path || location.startsWith('$path/');
  }

  @override
  Widget build(BuildContext context) {
    final delegate = context.sdRouter;

    return ListenableBuilder(
      listenable: delegate,
      builder: (context, _) {
        final theme = context.sdNavBarTheme;
        final location = delegate.location;

        final bg = style?.backgroundColor ?? theme.backgroundColor;
        final activeColor = style?.activeColor ?? theme.activeColor;
        final inactiveColor = style?.inactiveColor ?? theme.inactiveColor;
        final indicatorColor = style?.indicatorColor ?? theme.indicatorColor;
        final borderColor = style?.borderColor ?? theme.borderColor;
        final borderRadius = style?.borderRadius ?? theme.borderRadius;
        final margin = style?.margin ?? theme.margin;
        final padding = style?.padding ?? theme.padding;
        final itemPadding = style?.itemPadding ?? theme.itemPadding;
        final iconSize = style?.iconSize ?? theme.iconSize;
        final showLabels = style?.showLabels ?? theme.showLabels;

        return SafeArea(
          child: Padding(
            padding: margin,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: borderRadius,
                border: Border.all(color: borderColor),
              ),
              child: Padding(
                padding: padding,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: items.map((item) {
                    final active = _isActive(location, item.path);
                    return Expanded(
                      child: _SdNavBarItemWidget(
                        item: item,
                        active: active,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        indicatorColor: indicatorColor,
                        indicatorBorderRadius: borderRadius,
                        iconSize: iconSize,
                        labelStyle: theme.labelStyle,
                        itemPadding: itemPadding,
                        showLabels: showLabels,
                        onTap: () => delegate.go(item.path),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// _SdNavBarItemWidget
// ---------------------------------------------------------------------------

class _SdNavBarItemWidget extends StatelessWidget {
  const _SdNavBarItemWidget({
    required this.item,
    required this.active,
    required this.activeColor,
    required this.inactiveColor,
    required this.indicatorColor,
    required this.indicatorBorderRadius,
    required this.iconSize,
    required this.labelStyle,
    required this.itemPadding,
    required this.showLabels,
    required this.onTap,
  });

  final SdNavBarItem item;
  final bool active;
  final Color activeColor;
  final Color inactiveColor;
  final Color indicatorColor;
  final BorderRadius indicatorBorderRadius;
  final double iconSize;
  final TextStyle labelStyle;
  final EdgeInsets itemPadding;
  final bool showLabels;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: active ? indicatorColor : const Color(0x00000000),
          borderRadius: indicatorBorderRadius,
        ),
        padding: itemPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedTheme(
              data: Theme.of(context),
              child: IconTheme(
                data: IconThemeData(color: color, size: iconSize),
                child: item.icon,
              ),
            ),
            if (showLabels) ...[
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                style: labelStyle.copyWith(color: color),
                child: Text(item.label),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
