# system_design — Claude Code Rules

## Package Philosophy

- **Zero external dependencies.** Only the `flutter` SDK. Never add `google_fonts`, `go_router`, or any third-party package.
- **Nothing hardcoded.** Every visual value (color, size, radius, font, spacing) must originate from `SystemDesignTheme` or a per-component `Sd*Theme` extension. If you find a hardcoded value, replace it.
- **Public API surface lives exclusively in `lib/system_design.dart`.** Never ask consumers to import `lib/src/` paths directly.
- **Minimalist black & white aesthetic.** No gradients, no colored accents, no shadows unless they are token-driven. The design should look clean on white and on black backgrounds equally.

## Code Conventions

- **File naming:** `snake_case.dart`. Widget class naming: `Sd` prefix (`SdButton`, `SdList`, `SdDialog`).
- **All code and comments in English.**
- **Every public widget accepts an optional `style` parameter** (its component-specific style object) for per-instance overrides, in addition to the global theme.
- **Prefer `StatelessWidget`** over `StatefulWidget`. Only use `StatefulWidget` when managing animation controllers, overlay entries, or similar lifecycle concerns.
- **Never use `BuildContext` across async gaps** without a `.mounted` check.
- **No `print()` calls** in production code. Use `assert()` for internal invariants.
- **Immutable value objects** for all style/theme classes. Use `const` constructors wherever possible.

## Theme Rules

- Design tokens live in `lib/src/theme/`. Components must never define their own raw color or spacing values.
- Components read tokens via `context.sdTheme` (the `BuildContext` extension in `sd_extensions.dart`).
- Every `ThemeExtension` subclass must implement `copyWith` and `lerp` correctly — `lerp` must use `Color.lerp`, `lerpDouble`, etc. as appropriate.
- `SystemDesignThemeData.light()` and `.dark()` are the only factory entry points for consumers. No other way to produce a configured `ThemeData` should be needed.

## Font Rules

- Inter is bundled in `assets/fonts/`. **Never add `google_fonts` or any other font package.**
- Font family is always sourced from `SystemDesignTheme.fontFamily` (default `'Inter'`), never hardcoded in any style or widget.
- Consumers can override by passing `fontFamily:` to `SystemDesignThemeData.light()`.

## Adding a New Component

Every new component requires all of:
1. `lib/src/components/<name>/sd_<name>.dart` — the widget
2. `lib/src/components/<name>/sd_<name>_theme.dart` — `ThemeExtension` for global defaults
3. `lib/src/components/<name>/sd_<name>_style.dart` — immutable per-instance style object
4. `test/components/<name>/sd_<name>_test.dart` — widget tests
5. Export all files from `lib/system_design.dart`
6. Add a section in `README.md` under **Components**
7. Add an entry in `CHANGELOG.md`

## Testing

- Each component has a corresponding test in `test/components/<name>/`.
- Always wrap test widgets with `MaterialApp(theme: SystemDesignThemeData.light(), home: ...)`.
- Theme extension tests live in `test/theme/`.
- Tests must not rely on pixel-perfect rendering — test behaviour, accessibility, and state.

## Self-Improvement Rule

**When corrected by the user, record the lesson here immediately.** Add a dated entry under the Lessons Learned section so future sessions do not repeat the same mistake.

## Lessons Learned

<!-- Format: - [YYYY-MM-DD] What went wrong → What to do instead -->
- [2026-03-17] `SdToasterScope` was documented/used as a wrapper *above* `MaterialApp`, causing a "No Directionality widget found" crash. `Stack` requires `Directionality`, which only exists inside `MaterialApp`. → Always place `SdToasterScope` **inside** `MaterialApp` via its `builder:` parameter: `builder: (context, child) => SdToasterScope(child: child!)`. Never place it above `MaterialApp`.
- [2026-03-17] When appending the `flutter.fonts` block to `pubspec.yaml`, the edit was inserted inside the `dependencies.flutter:` key instead of the top-level `flutter:` section, producing invalid YAML. → Always verify the YAML indentation level when editing `pubspec.yaml`. The `flutter:` section with `fonts:` must be a top-level key, not nested under `dependencies`.

## Research Rule

**Before implementing any Flutter API, pattern, or behaviour that is not 100% certain,** use web search to get the current official documentation. Do not guess or rely on potentially outdated training data. This applies especially to:
- Navigator 2.0 APIs (`RouterDelegate`, `RouteInformationParser`, `RouterConfig`)
- `ThemeExtension` `lerp` contracts
- `OverlayEntry` / `Overlay` lifecycle
- Any Flutter API added after Flutter 3.0
