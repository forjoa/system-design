/// Spacing scale based on a 4pt grid.
///
/// All components source their padding, gaps, and margins from this scale
/// to ensure visual consistency across the library.
class SystemDesignSpacing {
  const SystemDesignSpacing({
    this.xs = 4,
    this.sm = 8,
    this.md = 16,
    this.lg = 24,
    this.xl = 32,
    this.xxl = 48,
  });

  /// 4pt — tight internal padding, icon gaps.
  final double xs;

  /// 8pt — compact padding, inline spacing.
  final double sm;

  /// 16pt — default content padding.
  final double md;

  /// 24pt — section spacing.
  final double lg;

  /// 32pt — large section gaps.
  final double xl;

  /// 48pt — page-level spacing.
  final double xxl;

  static const SystemDesignSpacing defaults = SystemDesignSpacing();

  SystemDesignSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return SystemDesignSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  SystemDesignSpacing lerp(SystemDesignSpacing other, double t) {
    return SystemDesignSpacing(
      xs: xs + (other.xs - xs) * t,
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      xxl: xxl + (other.xxl - xxl) * t,
    );
  }
}
