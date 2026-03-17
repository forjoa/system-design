# system_design

A minimalist, zero-dependency Flutter component library with a black & white design system, Inter font, and a built-in declarative router.

---

## Features

- **Token-based theme system** — all visual values (color, spacing, radius, typography) are sourced from `SystemDesignTheme`, a `ThemeExtension` that participates in Flutter's native theming and lerp system.
- **Bundled Inter font** — no `google_fonts` dependency needed. Inter is included as package assets and resolved automatically.
- **Dark mode** — `SystemDesignThemeData.dark()` inverts the palette. All components adapt automatically.
- **Zero external dependencies** — only the Flutter SDK.
- **Five components** — `SdButton`, `SdList`/`SdListItem`, `SdDialog`, `SdToaster`, and a Navigator 2.0 declarative `SdRouter`.
- **Per-component theme overrides** — each component has its own `ThemeExtension` (`SdButtonTheme`, etc.) for global customisation, plus an optional `style:` parameter for per-instance overrides.

---

## Getting started

### Installation

In your `pubspec.yaml`:

```yaml
dependencies:
  system_design:
    git:
      url: https://github.com/forjoa/system-design.git
      ref: main
```

Then:

```sh
flutter pub get
```

### Setup

Use `MaterialApp`'s `builder:` parameter to inject `SdToasterScope` **inside** `MaterialApp` (required — `SdToasterScope` needs `Directionality` and `Theme` from `MaterialApp`):

```dart
import 'package:system_design/system_design.dart';

void main() {
  runApp(
    MaterialApp(
      theme: SystemDesignThemeData.light(),
      darkTheme: SystemDesignThemeData.dark(),
      builder: (context, child) => SdToasterScope(child: child!),
      home: const MyApp(),
    ),
  );
}
```

To use the built-in router, use `MaterialApp.router` with the same `builder:` pattern:

```dart
MaterialApp.router(
  theme: SystemDesignThemeData.light(),
  builder: (context, child) => SdToasterScope(child: child!),
  routerConfig: SdRouterConfig(
    routes: [
      SdRoute(path: '/', builder: (_, _) => const HomePage()),
      SdRoute(path: '/settings', builder: (_, _) => const SettingsPage()),
    ],
  ).build(),
)
```

---

## Components

### SdButton

```dart
// Variants: filled (default), outlined, ghost, destructive
SdButton(
  label: 'Continue',
  onPressed: () {},
)

SdButton(
  label: 'Delete',
  variant: SdButtonVariant.destructive,
  size: SdButtonSize.lg,
  onPressed: () {},
)

// With icon, loading, disabled
SdButton(
  label: 'Upload',
  icon: const Icon(Icons.upload),
  isLoading: true,
  onPressed: () {},
)
```

**Parameters:**

| Parameter | Type | Default |
|---|---|---|
| `label` | `String` | required |
| `onPressed` | `VoidCallback?` | required |
| `variant` | `SdButtonVariant` | `filled` |
| `size` | `SdButtonSize` | `md` |
| `icon` | `Widget?` | — |
| `trailingIcon` | `Widget?` | — |
| `isLoading` | `bool` | `false` |
| `isDisabled` | `bool` | `false` |
| `style` | `SdButtonStyle?` | — |

---

### SdList / SdListItem

```dart
SdList<String>(
  items: myItems,
  itemBuilder: (context, item, index) => SdListItem(
    title: Text(item.title),
    subtitle: Text(item.subtitle),
    leading: const Icon(Icons.inbox),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {},
  ),
  emptyState: const Center(child: Text('Nothing here yet.')),
)
```

`SdList` is a styled wrapper over `ListView.builder`. It adds consistent separators, header/footer slots, and an empty state widget.

---

### SdDialog

```dart
// Show as a modal route
showSdDialog(
  context: context,
  builder: (_) => SdDialog(
    title: const Text('Confirm'),
    description: 'This action cannot be undone.',
    actions: [
      SdButton(
        label: 'Cancel',
        variant: SdButtonVariant.ghost,
        onPressed: () => Navigator.of(context).pop(),
      ),
      SdButton(
        label: 'Delete',
        variant: SdButtonVariant.destructive,
        onPressed: () => Navigator.of(context).pop(true),
      ),
    ],
  ),
);
```

`SdDialog` is a plain `StatelessWidget` — use it inline or via `showSdDialog`.

---

### SdToaster

```dart
// Show a toast anywhere below SdToasterScope
SdToasterScope.of(context).show(
  const SdToast(
    title: 'Saved',
    message: 'Your changes have been saved.',
    variant: SdToastVariant.success,
  ),
);

// With an inline action
SdToasterScope.of(context).show(
  SdToast(
    message: 'Item deleted.',
    action: SdToastAction(label: 'Undo', onPressed: () {}),
  ),
);
```

Variants: `defaultVariant`, `success`, `warning`, `destructive`. All variants are monochrome — the icon shape distinguishes them, not color.

---

### SdRouter

```dart
// Configure
final routerConfig = SdRouterConfig(
  routes: [
    SdRoute(
      path: '/',
      builder: (_, _) => const HomePage(),
    ),
    SdRoute(
      path: '/users/:id',
      builder: (context, args) => UserPage(id: args.pathParams['id']!),
    ),
    // Redirect guard
    SdRoute(
      path: '/admin',
      redirectIf: (args) => !isLoggedIn,
      redirectTo: '/login',
      builder: (_, _) => const AdminPage(),
    ),
    // Shell route (persistent nav bar)
    SdShellRoute(
      path: '/app',
      shell: (context, child) => AppShell(body: child),
      routes: [
        SdRoute(path: '/app/home', builder: (_, _) => const Home()),
        SdRoute(path: '/app/settings', builder: (_, _) => const Settings()),
      ],
    ),
  ],
).build();

// Navigate
context.sdRouter.push('/users/42');
context.sdRouter.go('/dashboard');
context.sdRouter.pop();
```

Page transitions: `SdPageTransition.fade` (default), `slide`, `scale`, `none`.

---

## Theming

### Customising the color palette

```dart
SystemDesignThemeData.light(
  colors: SystemDesignColors.light.copyWith(
    primary: const Color(0xFF1A1A1A),
    border: const Color(0xFFCCCCCC),
  ),
)
```

### Customising typography

```dart
SystemDesignThemeData.light(
  typography: SystemDesignTypography.fromFontFamily('Geist'),
)
```

### Swapping the font family

Inter is the default. Pass any registered font family name:

```dart
SystemDesignThemeData.light(fontFamily: 'Roboto')
```

### Per-component global overrides

```dart
SystemDesignThemeData.light(
  buttonTheme: SdButtonTheme.fromSdTheme(myTheme).copyWith(
    pressedScale: 0.95,
  ),
)
```

### Per-instance overrides

Every widget accepts an optional `style:` parameter:

```dart
SdButton(
  label: 'Custom',
  style: const SdButtonStyle(
    borderRadius: BorderRadius.zero,
    pressedOpacity: 0.5,
  ),
  onPressed: () {},
)
```

### Reading tokens in custom widgets

```dart
final theme = context.sdTheme;

Container(
  color: theme.colors.surface,
  padding: EdgeInsets.all(theme.spacing.md),
  child: Text('Hello', style: theme.typography.bodyMedium),
)
```

---

## Examples

### Full component showcase
[`example/`](example/) — demonstrates all components (Button, List, Dialog, Toaster) and the router with the default black & white palette.

### Custom colors
[`example-custom-colors/`](example-custom-colors/) — demonstrates runtime palette switching. Three hand-crafted palettes (Ocean, Forest, Sunset) are defined as plain `const SystemDesignColors(...)` instances and passed to `SystemDesignThemeData.dark(colors: ...)`. Every component — buttons, list, dialog, toaster — updates automatically.

```dart
const myColors = SystemDesignColors(
  background: Color(0xFF0D1B2A),
  surface: Color(0xFF1B2E42),
  foreground: Color(0xFFE8F4FD),
  primary: Color(0xFF4A9ECA),
  primaryForeground: Color(0xFF0D1B2A),
  // ... other semantic roles
);

MaterialApp(
  theme: SystemDesignThemeData.dark(colors: myColors),
  builder: (context, child) => SdToasterScope(child: child!),
  home: const MyHomePage(),
)
```

No subclassing, no special files, no registration — just pass a `SystemDesignColors` with your values and every component picks them up.

---

## License

MIT © Joaquin Trujillo
