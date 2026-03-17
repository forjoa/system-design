import 'package:flutter/painting.dart';

/// Border radius scale for the system design library.
class SystemDesignRadius {
  const SystemDesignRadius({
    this.none = 0,
    this.sm = 4,
    this.md = 8,
    this.lg = 12,
    this.xl = 16,
    this.full = 999,
  });

  /// No rounding — sharp corners.
  final double none;

  /// 4pt — subtle rounding for inputs, small chips.
  final double sm;

  /// 8pt — default rounding for buttons, cards.
  final double md;

  /// 12pt — larger cards, dialogs.
  final double lg;

  /// 16pt — panels, sheets.
  final double xl;

  /// 999pt — pill / fully rounded shape.
  final double full;

  static const SystemDesignRadius defaults = SystemDesignRadius();

  BorderRadius asBorderRadius(double value) =>
      BorderRadius.circular(value);

  SystemDesignRadius copyWith({
    double? none,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) {
    return SystemDesignRadius(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      full: full ?? this.full,
    );
  }

  SystemDesignRadius lerp(SystemDesignRadius other, double t) {
    return SystemDesignRadius(
      none: none + (other.none - none) * t,
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      full: full + (other.full - full) * t,
    );
  }
}
