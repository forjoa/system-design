import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import 'sd_toast.dart';
import 'sd_toaster_controller.dart';

export 'sd_toast.dart';
export 'sd_toaster_controller.dart';
export 'sd_toaster_theme.dart';

/// Entry stored in the toaster state.
class _ToastEntry {
  _ToastEntry({required this.id, required this.toast});

  final String id;
  final SdToast toast;
  Timer? timer;

  /// Key used to trigger the exit animation on the widget before removal.
  final animatedKey = GlobalKey<_AnimatedToastState>();
}

/// [InheritedWidget] that exposes [SdToasterController] down the tree.
class _SdToasterInherited extends InheritedWidget {
  const _SdToasterInherited({
    required this.controller,
    required super.child,
  });

  final SdToasterController controller;

  @override
  bool updateShouldNotify(_SdToasterInherited oldWidget) =>
      controller != oldWidget.controller;
}

/// Wraps the widget tree and provides a toast overlay.
///
/// Place inside [MaterialApp] via the `builder:` parameter:
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => SdToasterScope(child: child!),
/// )
/// ```
///
/// Then show toasts anywhere below:
/// ```dart
/// SdToasterScope.of(context).show(
///   SdToast(message: 'Saved!', variant: SdToastVariant.success),
/// );
/// ```
class SdToasterScope extends StatefulWidget {
  const SdToasterScope({
    super.key,
    required this.child,
    this.alignment = Alignment.bottomCenter,
  });

  final Widget child;

  /// Where toasts appear on screen.
  final AlignmentGeometry alignment;

  /// Returns the nearest [SdToasterController].
  static SdToasterController of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_SdToasterInherited>();
    assert(
      inherited != null,
      'SdToasterScope.of() called with no SdToasterScope in the tree.',
    );
    return inherited!.controller;
  }

  @override
  State<SdToasterScope> createState() => _SdToasterScopeState();
}

class _SdToasterScopeState extends State<SdToasterScope>
    implements SdToasterController {
  final List<_ToastEntry> _entries = [];
  int _idCounter = 0;

  // ---------------------------------------------------------------------------
  // SdToasterController
  // ---------------------------------------------------------------------------

  @override
  String show(SdToast toast) {
    final id = '${++_idCounter}';
    final entry = _ToastEntry(id: id, toast: toast);

    setState(() {
      _entries.add(entry);
      final maxVisible = _maxVisible;
      if (_entries.length > maxVisible) {
        // Instantly remove oldest entries beyond the limit — no animation needed
        // since they are already off-screen (covered by newer toasts).
        _entries.removeRange(0, _entries.length - maxVisible);
      }
    });

    if (toast.duration > Duration.zero) {
      entry.timer = Timer(toast.duration, () => dismiss(id));
    }
    return id;
  }

  @override
  void dismiss(String id) {
    if (!mounted) return;
    final idx = _entries.indexWhere((e) => e.id == id);
    if (idx == -1) return;

    final entry = _entries[idx];
    entry.timer?.cancel();

    // Ask the widget to play its exit animation, then remove the entry.
    entry.animatedKey.currentState?.animateOut(() {
      if (!mounted) return;
      setState(() => _entries.removeWhere((e) => e.id == id));
    });
  }

  @override
  void dismissAll() {
    if (!mounted) return;
    // Copy so we can iterate while dismiss mutates _entries.
    final ids = _entries.map((e) => e.id).toList();
    for (final id in ids) {
      dismiss(id);
    }
  }

  int get _maxVisible {
    try {
      return context.sdToasterTheme.maxVisible;
    } catch (_) {
      return 3;
    }
  }

  @override
  void dispose() {
    for (final e in _entries) {
      e.timer?.cancel();
    }
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return _SdToasterInherited(
      controller: this,
      child: Stack(
        children: [
          widget.child,
          if (_entries.isNotEmpty) _buildOverlay(context),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final theme = context.sdToasterTheme;

    return Positioned.fill(
      child: Align(
        alignment: widget.alignment,
        child: Padding(
          padding: theme.edgeInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < _entries.length; i++) ...[
                if (i > 0) SizedBox(height: theme.toastSpacing),
                _AnimatedToast(
                  key: _entries[i].animatedKey,
                  child: _entries[i].toast,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Wraps a toast with entrance and exit animations.
class _AnimatedToast extends StatefulWidget {
  const _AnimatedToast({super.key, required this.child});
  final Widget child;

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<_AnimatedToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _translateY;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      reverseDuration: const Duration(milliseconds: 260),
    );

    final curvedIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
        reverseCurve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );

    _translateY = Tween<double>(begin: -16, end: 0).animate(curvedIn);
    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(curvedIn);

    _controller.forward();
  }

  /// Plays the exit animation, then calls [onDone] when complete.
  void animateOut(VoidCallback onDone) {
    _controller.reverse().whenComplete(onDone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: Offset(0, _translateY.value),
          child: Transform.scale(
            scale: _scale.value,
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
