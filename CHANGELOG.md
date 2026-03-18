# Changelog

All notable changes to this package are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [0.1.5] - 2026-03-18

### Added
- `SdNavBar` — floating, pill-shaped bottom navigation bar that integrates with `SdRouterConfig`. Reactively tracks the active route via `ListenableBuilder` on `SdRouterDelegate`. Renders icon + label per tab with an animated pill indicator behind the active item.
- `SdNavBarItem` — data class holding `path`, `icon`, and `label` for each tab.
- `SdNavBarTheme` — `ThemeExtension` with tokens for `backgroundColor`, `activeColor`, `inactiveColor`, `indicatorColor`, `borderColor`, `borderRadius`, `margin`, `padding`, `itemPadding`, `iconSize`, `labelStyle`, and `showLabels`. Registered automatically in `SystemDesignThemeData.light()` / `.dark()`.
- `SdNavBarStyle` — per-instance style override for `SdNavBar`.
- `context.sdNavBarTheme` — `BuildContext` extension accessor.
- README: added `SdNavBar` component section with usage example and parameter tables.
- `example/` updated to use `SdShellRoute` + `SdNavBar` with `lucide_icons` (added as example-only dependency).

### Changed
- `SdButton` filled and destructive variants now render a subtle top-to-bottom gradient (white blend `26%` at the top) controlled by the new `SdButtonTheme.gradientHighlightAmount` token. Ghost and outlined variants are unaffected. Set `gradientHighlightAmount: 0` to disable.

---

## [0.1.4] - 2026-03-17

### Added
- `example-custom-colors/` — new example app (iOS + Android) demonstrating runtime palette switching. Defines three `const SystemDesignColors` palettes (Ocean, Forest, Sunset) and passes them to `SystemDesignThemeData.dark(colors: ...)`. All components adapt automatically.
- README: added custom colors usage guide and links to both example apps.

---

## [0.1.3] - 2026-03-17

### Fixed
- `SdDialog` now respects a `margin` on all sides, preventing it from stretching edge-to-edge on small screens. Defaults to `horizontal: spacing.lg` (24pt). Configurable via `SdDialogTheme.margin` or `SdDialogStyle.margin`.

---

## [0.1.2] - 2026-03-17

### Fixed
- Toasts now animate out with the same fade + slide + scale transition as the entrance (reversed). Previously they disappeared instantly. Implemented via `animateOut()` on `_AnimatedToastState` using a `GlobalKey`, triggered before the entry is removed from the list. Exit uses `Curves.easeInCubic` at 260ms.

---

## [0.1.1] - 2026-03-17

### Fixed
- `SdToasterScope` crashed with "No Directionality widget found" when placed above `MaterialApp`. The correct usage is `MaterialApp(builder: (context, child) => SdToasterScope(child: child!))`. README and example updated accordingly.
- Toast text rendered with yellow underlines due to missing `Material` ancestor. Wrapped `SdToast` content in `Material(color: Colors.transparent)` and set `TextDecoration.none` explicitly on all text styles.
- Deprecated `Matrix4.translate`/`scale` cascade replaced with `Transform.translate` + `Transform.scale` widgets.

### Improved
- Toast entrance animation is smoother: uses `Curves.easeOutCubic`, 380ms duration, 16px pixel-based upward slide, and a subtle scale-up from 0.95 → 1.0 anchored at the bottom center. Opacity fades in over the first 60% of the animation.
- `example/` now correctly declares `flutter_lints` as a dev dependency, resolving the `analysis_options.yaml` include warning.

---

## [0.1.0] - 2026-03-17

### Added

#### Theme system
- `SystemDesignColors` — semantic black & white palette with light and dark presets. Roles: `background`, `surface`, `foreground`, `muted`, `subtle`, `primary`, `primaryForeground`, `border`, `destructive`, `success`.
- `SystemDesignSpacing` — 4pt grid scale: `xs` (4), `sm` (8), `md` (16), `lg` (24), `xl` (32), `xxl` (48).
- `SystemDesignRadius` — border radius scale: `none`, `sm`, `md`, `lg`, `xl`, `full`.
- `SystemDesignTypography` — type scale built from a font family string: `displayLarge/Medium`, `headingLarge/Medium/Small`, `bodyLarge/Medium/Small`, `labelLarge/Medium/Small`, `code`.
- `SystemDesignTheme` — root `ThemeExtension<SystemDesignTheme>` combining all tokens. Implements `copyWith` and `lerp`.
- `SystemDesignThemeData` — `light()` and `dark()` factory methods producing a fully configured `ThemeData` with all extensions registered.

#### Components
- `SdButton` — four variants (`filled`, `outlined`, `ghost`, `destructive`), three sizes (`sm`, `md`, `lg`), loading and disabled states, optional leading/trailing icons, press animation (scale + opacity). Zero Material widget dependencies.
- `SdButtonTheme` / `SdButtonStyle` — global and per-instance overrides.
- `SdList<T>` — generic styled wrapper over `ListView.builder` with separator, header, footer, and empty-state support.
- `SdListItem` — row widget with title, subtitle, leading, trailing, selected and disabled states, hover feedback.
- `SdListTheme` / `SdListStyle` / `SdListItemStyle` — global and per-instance overrides.
- `SdDivider` — themed horizontal rule.
- `SdDialog` — modal dialog widget with title, description, free-form body, and actions row.
- `showSdDialog<T>()` — shows `SdDialog` via `showGeneralDialog` with fade+scale transition.
- `SdDialogTheme` / `SdDialogStyle` — global and per-instance overrides.
- `SdToasterScope` — overlay wrapper that provides `SdToasterController` via `InheritedWidget`.
- `SdToast` — toast widget with title, message, four variants (`defaultVariant`, `success`, `warning`, `destructive`), optional inline action, and configurable duration.
- `SdToasterController` — `show()`, `dismiss()`, `dismissAll()` API. Access via `SdToasterScope.of(context)`.
- `SdToasterTheme` / `SdToastStyle` — global and per-instance overrides.
- `SdRouter` / `SdRouterDelegate` — Navigator 2.0 declarative router. Supports path parameters (`:id`), query parameters, and programmatic navigation (`push`, `go`, `pop`).
- `SdRoute` — route definition with optional redirect guard (`redirectIf` / `redirectTo`).
- `SdShellRoute` — shell layout route for persistent navigation (bottom nav bar, sidebar).
- `SdRouterConfig` — builder that produces a `RouterConfig<SdRouteUri>` for `MaterialApp.router`.
- `SdPageTransition` — four transition styles: `none`, `fade`, `slide`, `scale`.
- `SdTransitionPage` — `Page<T>` subclass implementing the chosen transition.

#### Utilities
- `SdThemeContext` extension on `BuildContext` — `sdTheme`, `sdButtonTheme`, `sdListTheme`, `sdDialogTheme`, `sdToasterTheme`.
- `SdRouterContext` extension on `BuildContext` — `sdRouter` for programmatic navigation.

#### Assets
- Bundled Inter font (Regular 400, Medium 500, SemiBold 600, Bold 700). OFL licensed.

#### Developer experience
- Full `.claude/CLAUDE.md` ruleset for consistent AI-assisted development.
- `example/` app showcasing all components and the router.

---

## [0.0.1] - initial scaffold

- Flutter package scaffold generated by `flutter create`.
