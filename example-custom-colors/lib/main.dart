import 'package:flutter/material.dart';
import 'package:system_design/system_design.dart';

// ---------------------------------------------------------------------------
// Custom color palettes
// ---------------------------------------------------------------------------

/// Ocean — deep blue tones.
const _oceanColors = SystemDesignColors(
  background: Color(0xFF0D1B2A),
  surface: Color(0xFF1B2E42),
  overlay: Color(0x0AFFFFFF),
  foreground: Color(0xFFE8F4FD),
  muted: Color(0xFF7BAFD4),
  subtle: Color(0xFF3A5A7A),
  primary: Color(0xFF4A9ECA),
  primaryForeground: Color(0xFF0D1B2A),
  border: Color(0xFF2A4A6A),
  destructive: Color(0xFFCA6A4A),
  destructiveForeground: Color(0xFFE8F4FD),
  success: Color(0xFF4ACAA0),
  successForeground: Color(0xFF0D1B2A),
);

/// Forest — earthy greens.
const _forestColors = SystemDesignColors(
  background: Color(0xFF0F1A0F),
  surface: Color(0xFF1A2E1A),
  overlay: Color(0x0AFFFFFF),
  foreground: Color(0xFFE8F5E8),
  muted: Color(0xFF7ABD7A),
  subtle: Color(0xFF3A5E3A),
  primary: Color(0xFF5ABD5A),
  primaryForeground: Color(0xFF0F1A0F),
  border: Color(0xFF2A4A2A),
  destructive: Color(0xFFBD5A5A),
  destructiveForeground: Color(0xFFE8F5E8),
  success: Color(0xFF5ABDAA),
  successForeground: Color(0xFF0F1A0F),
);

/// Sunset — warm oranges and purples.
const _sunsetColors = SystemDesignColors(
  background: Color(0xFF1A0F1A),
  surface: Color(0xFF2E1A2E),
  overlay: Color(0x0AFFFFFF),
  foreground: Color(0xFFF5E8F5),
  muted: Color(0xFFBD7ABD),
  subtle: Color(0xFF5E3A5E),
  primary: Color(0xFFE07A30),
  primaryForeground: Color(0xFF1A0F1A),
  border: Color(0xFF4A2A4A),
  destructive: Color(0xFFE05050),
  destructiveForeground: Color(0xFFF5E8F5),
  success: Color(0xFF70BD70),
  successForeground: Color(0xFF1A0F1A),
);

// ---------------------------------------------------------------------------
// App
// ---------------------------------------------------------------------------

void main() {
  runApp(const CustomColorsApp());
}

class CustomColorsApp extends StatefulWidget {
  const CustomColorsApp({super.key});

  @override
  State<CustomColorsApp> createState() => _CustomColorsAppState();
}

class _CustomColorsAppState extends State<CustomColorsApp> {
  Palette _selected = Palette.ocean;

  SystemDesignColors get _colors => switch (_selected) {
        Palette.ocean => _oceanColors,
        Palette.forest => _forestColors,
        Palette.sunset => _sunsetColors,
      };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Colors',
      theme: SystemDesignThemeData.dark(colors: _colors),
      builder: (context, child) => SdToasterScope(child: child!),
      home: HomePage(
        selected: _selected,
        onPaletteChanged: (p) => setState(() => _selected = p),
      ),
    );
  }
}

enum Palette { ocean, forest, sunset }

// ---------------------------------------------------------------------------
// Home page
// ---------------------------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.selected,
    required this.onPaletteChanged,
  });

  final Palette selected;
  final ValueChanged<Palette> onPaletteChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Custom Colors',
                style: theme.typography.displayMedium
                    .copyWith(color: theme.colors.foreground),
              ),
              SizedBox(height: theme.spacing.xs),
              Text(
                'Every component adapts automatically when you pass a custom '
                'SystemDesignColors to SystemDesignThemeData.',
                style: theme.typography.bodyMedium
                    .copyWith(color: theme.colors.muted),
              ),

              SizedBox(height: theme.spacing.xl),

              // Palette switcher
              Text(
                'Choose a palette',
                style: theme.typography.labelLarge
                    .copyWith(color: theme.colors.muted),
              ),
              SizedBox(height: theme.spacing.sm),
              Row(
                children: [
                  PaletteChip(
                    label: 'Ocean',
                    color: _oceanColors.primary,
                    isSelected: selected == Palette.ocean,
                    onTap: () => onPaletteChanged(Palette.ocean),
                  ),
                  SizedBox(width: theme.spacing.sm),
                  PaletteChip(
                    label: 'Forest',
                    color: _forestColors.primary,
                    isSelected: selected == Palette.forest,
                    onTap: () => onPaletteChanged(Palette.forest),
                  ),
                  SizedBox(width: theme.spacing.sm),
                  PaletteChip(
                    label: 'Sunset',
                    color: _sunsetColors.primary,
                    isSelected: selected == Palette.sunset,
                    onTap: () => onPaletteChanged(Palette.sunset),
                  ),
                ],
              ),

              SizedBox(height: theme.spacing.xl),
              CustomDivider(),
              SizedBox(height: theme.spacing.xl),

              // Buttons
              _Section(label: 'Buttons'),
              SizedBox(height: theme.spacing.md),
              Wrap(
                spacing: theme.spacing.sm,
                runSpacing: theme.spacing.sm,
                children: [
                  SdButton(label: 'Filled', onPressed: () {}),
                  SdButton(
                    label: 'Outlined',
                    variant: SdButtonVariant.outlined,
                    onPressed: () {},
                  ),
                  SdButton(
                    label: 'Ghost',
                    variant: SdButtonVariant.ghost,
                    onPressed: () {},
                  ),
                  SdButton(
                    label: 'Destructive',
                    variant: SdButtonVariant.destructive,
                    onPressed: () {},
                  ),
                ],
              ),

              SizedBox(height: theme.spacing.xl),
              CustomDivider(),
              SizedBox(height: theme.spacing.xl),

              // List
              _Section(label: 'List'),
              SizedBox(height: theme.spacing.md),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colors.border),
                  borderRadius: BorderRadius.circular(theme.radius.md),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(theme.radius.md),
                  child: SdList<String>(
                    shrinkWrap: true,
                    items: const ['Dashboard', 'Analytics', 'Settings'],
                    itemBuilder: (context, item, index) => SdListItem(
                      title: Text(item),
                      leading: const Icon(Icons.circle_outlined),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ),
                ),
              ),

              SizedBox(height: theme.spacing.xl),
              CustomDivider(),
              SizedBox(height: theme.spacing.xl),

              // Dialog
              _Section(label: 'Dialog'),
              SizedBox(height: theme.spacing.md),
              SdButton(
                label: 'Open Dialog',
                variant: SdButtonVariant.outlined,
                onPressed: () => showSdDialog(
                  context: context,
                  builder: (_) => SdDialog(
                    title: const Text('Confirm action'),
                    description:
                        'This dialog inherits the active color palette. '
                        'Switch palettes and open it again.',
                    actions: [
                      SdButton(
                        label: 'Cancel',
                        variant: SdButtonVariant.ghost,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SdButton(
                        label: 'Confirm',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: theme.spacing.xl),
              CustomDivider(),
              SizedBox(height: theme.spacing.xl),

              // Toasts
              _Section(label: 'Toaster'),
              SizedBox(height: theme.spacing.md),
              Wrap(
                spacing: theme.spacing.sm,
                runSpacing: theme.spacing.sm,
                children: [
                  SdButton(
                    label: 'Default',
                    variant: SdButtonVariant.outlined,
                    onPressed: () => SdToasterScope.of(context).show(
                      const SdToast(message: 'Palette applied.'),
                    ),
                  ),
                  SdButton(
                    label: 'Success',
                    variant: SdButtonVariant.outlined,
                    onPressed: () => SdToasterScope.of(context).show(
                      const SdToast(
                        title: 'Success',
                        message: 'Colors saved successfully.',
                        variant: SdToastVariant.success,
                      ),
                    ),
                  ),
                  SdButton(
                    label: 'Destructive',
                    variant: SdButtonVariant.outlined,
                    onPressed: () => SdToasterScope.of(context).show(
                      const SdToast(
                        title: 'Error',
                        message: 'Failed to apply palette.',
                        variant: SdToastVariant.destructive,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: theme.spacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small reusable widgets
// ---------------------------------------------------------------------------

class PaletteChip extends StatelessWidget {
  const PaletteChip({
    super.key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(30) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : theme.colors.border,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(theme.radius.full),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: theme.spacing.xs),
            Text(
              label,
              style: theme.typography.labelMedium.copyWith(
                color: isSelected ? color : theme.colors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTheme;
    return Text(
      label,
      style: theme.typography.headingSmall
          .copyWith(color: theme.colors.foreground),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.sdTheme.colors.border,
    );
  }
}
