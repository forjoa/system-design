import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:system_design/system_design.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'system_design example',
      theme: SystemDesignThemeData.light(),
      darkTheme: SystemDesignThemeData.dark(),
      builder: (context, child) => SdToasterScope(child: child!),
      routerConfig: SdRouterConfig(
        initialLocation: '/home',
        routes: [
          SdShellRoute(
            path: '/',
            shell: (context, child) => _AppShell(body: child),
            routes: [
              SdRoute(path: '/home',     builder: (_, _) => const HomePage()),
              SdRoute(path: '/buttons',  builder: (_, _) => const ButtonsPage()),
              SdRoute(path: '/lists',    builder: (_, _) => const ListsPage()),
              SdRoute(path: '/dialog',   builder: (_, _) => const DialogPage()),
              SdRoute(path: '/toaster',  builder: (_, _) => const ToasterPage()),
            ],
          ),
        ],
      ).build(),
    );
  }
}

// ---------------------------------------------------------------------------
// App shell with floating nav bar
// ---------------------------------------------------------------------------

class _AppShell extends StatelessWidget {
  const _AppShell({required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      extendBody: true,
      body: body,
      bottomNavigationBar: SdNavBar(
        items: const [
          SdNavBarItem(
            path: '/home',
            icon: Icon(LucideIcons.home),
            label: 'Home',
          ),
          SdNavBarItem(
            path: '/buttons',
            icon: Icon(LucideIcons.mousePointer2),
            label: 'Buttons',
          ),
          SdNavBarItem(
            path: '/lists',
            icon: Icon(LucideIcons.list),
            label: 'Lists',
          ),
          SdNavBarItem(
            path: '/dialog',
            icon: Icon(LucideIcons.messageSquare),
            label: 'Dialog',
          ),
          SdNavBarItem(
            path: '/toaster',
            icon: Icon(LucideIcons.bell),
            label: 'Toaster',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Home
// ---------------------------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'system_design',
              style: theme.typography.displayMedium.copyWith(color: theme.colors.foreground),
            ),
            SizedBox(height: theme.spacing.sm),
            Text(
              'Component showcase',
              style: theme.typography.bodyLarge.copyWith(color: theme.colors.muted),
            ),
            SizedBox(height: theme.spacing.xl),
            Text(
              'Use the navigation bar below to explore components.',
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Buttons page
// ---------------------------------------------------------------------------

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.foreground,
        elevation: 0,
        title: Text('Buttons', style: theme.typography.headingMedium.copyWith(color: theme.colors.foreground)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Variants', style: theme.typography.headingSmall.copyWith(color: theme.colors.foreground)),
            SizedBox(height: theme.spacing.md),
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              children: [
                SdButton(label: 'Filled', onPressed: () {}),
                SdButton(label: 'Outlined', variant: SdButtonVariant.outlined, onPressed: () {}),
                SdButton(label: 'Ghost', variant: SdButtonVariant.ghost, onPressed: () {}),
                SdButton(label: 'Destructive', variant: SdButtonVariant.destructive, onPressed: () {}),
              ],
            ),
            SizedBox(height: theme.spacing.xl),
            Text('Sizes', style: theme.typography.headingSmall.copyWith(color: theme.colors.foreground)),
            SizedBox(height: theme.spacing.md),
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SdButton(label: 'Small', size: SdButtonSize.sm, onPressed: () {}),
                SdButton(label: 'Medium', onPressed: () {}),
                SdButton(label: 'Large', size: SdButtonSize.lg, onPressed: () {}),
              ],
            ),
            SizedBox(height: theme.spacing.xl),
            Text('States', style: theme.typography.headingSmall.copyWith(color: theme.colors.foreground)),
            SizedBox(height: theme.spacing.md),
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              children: [
                SdButton(label: 'Loading', isLoading: true, onPressed: () {}),
                SdButton(label: 'Disabled', isDisabled: true, onPressed: () {}),
              ],
            ),
            SizedBox(height: theme.spacing.xl),
            Text('With icons', style: theme.typography.headingSmall.copyWith(color: theme.colors.foreground)),
            SizedBox(height: theme.spacing.md),
            Wrap(
              spacing: theme.spacing.sm,
              runSpacing: theme.spacing.sm,
              children: [
                SdButton(
                  label: 'Leading icon',
                  icon: const Icon(LucideIcons.plus),
                  onPressed: () {},
                ),
                SdButton(
                  label: 'Trailing icon',
                  trailingIcon: const Icon(LucideIcons.arrowRight),
                  variant: SdButtonVariant.outlined,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Lists page
// ---------------------------------------------------------------------------

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  static const _items = ['Apples', 'Bananas', 'Cherries', 'Dates', 'Elderberries'];

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.foreground,
        elevation: 0,
        title: Text('Lists', style: theme.typography.headingMedium.copyWith(color: theme.colors.foreground)),
      ),
      body: SdList<String>(
        items: _items,
        header: Padding(
          padding: EdgeInsets.all(theme.spacing.md),
          child: Text('Fruits', style: theme.typography.labelLarge.copyWith(color: theme.colors.muted)),
        ),
        itemBuilder: (context, item, index) => SdListItem(
          title: Text(item),
          leading: const Icon(LucideIcons.circle),
          trailing: const Icon(LucideIcons.chevronRight),
          onTap: () {},
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dialog page
// ---------------------------------------------------------------------------

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.foreground,
        elevation: 0,
        title: Text('Dialog', style: theme.typography.headingMedium.copyWith(color: theme.colors.foreground)),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: SdButton(
            label: 'Open Dialog',
            icon: const Icon(LucideIcons.alertTriangle),
            onPressed: () => showSdDialog(
              context: context,
              builder: (_) => SdDialog(
                title: const Text('Confirm deletion'),
                description: 'This action cannot be undone. The item will be permanently deleted.',
                actions: [
                  SdButton(
                    label: 'Cancel',
                    variant: SdButtonVariant.ghost,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SdButton(
                    label: 'Delete',
                    variant: SdButtonVariant.destructive,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Toaster page
// ---------------------------------------------------------------------------

class ToasterPage extends StatelessWidget {
  const ToasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.background,
        foregroundColor: theme.colors.foreground,
        elevation: 0,
        title: Text('Toaster', style: theme.typography.headingMedium.copyWith(color: theme.colors.foreground)),
      ),
      body: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: [
            SdButton(
              label: 'Default',
              variant: SdButtonVariant.outlined,
              onPressed: () => SdToasterScope.of(context).show(
                const SdToast(message: 'Changes saved successfully.'),
              ),
            ),
            SdButton(
              label: 'Success',
              variant: SdButtonVariant.outlined,
              onPressed: () => SdToasterScope.of(context).show(
                const SdToast(
                  title: 'Success',
                  message: 'Your profile has been updated.',
                  variant: SdToastVariant.success,
                ),
              ),
            ),
            SdButton(
              label: 'Warning',
              variant: SdButtonVariant.outlined,
              onPressed: () => SdToasterScope.of(context).show(
                const SdToast(
                  title: 'Warning',
                  message: 'Your session will expire in 5 minutes.',
                  variant: SdToastVariant.warning,
                ),
              ),
            ),
            SdButton(
              label: 'Destructive',
              variant: SdButtonVariant.outlined,
              onPressed: () => SdToasterScope.of(context).show(
                const SdToast(
                  title: 'Error',
                  message: 'Failed to save changes. Please try again.',
                  variant: SdToastVariant.destructive,
                ),
              ),
            ),
            SdButton(
              label: 'With action',
              variant: SdButtonVariant.outlined,
              onPressed: () => SdToasterScope.of(context).show(
                SdToast(
                  message: 'Item moved to trash.',
                  action: SdToastAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
