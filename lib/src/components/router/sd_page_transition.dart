import 'package:flutter/material.dart';

/// Page transition styles for [SdRoute].
enum SdPageTransition {
  /// No animation — instant switch.
  none,

  /// Cross-fade between pages.
  fade,

  /// Slide in from the right (forward) / left (back).
  slide,

  /// Scale up from center.
  scale,
}

/// A [Page] subclass that applies the chosen [SdPageTransition].
class SdTransitionPage<T> extends Page<T> {
  const SdTransitionPage({
    required this.child,
    this.transition = SdPageTransition.fade,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final SdPageTransition transition;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, _, _) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return switch (transition) {
          SdPageTransition.none => child,
          SdPageTransition.fade => FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            ),
          SdPageTransition.slide => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            ),
          SdPageTransition.scale => ScaleTransition(
              scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              ),
            ),
        };
      },
    );
  }
}
