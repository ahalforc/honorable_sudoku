import 'package:flutter/material.dart' hide Color;
import 'package:honorable_sudoku/theme/theme.dart';

typedef ColorSelectedCallback = void Function(Color);
typedef ModeSelectedCallback = void Function(Mode);

class ThemePicker extends StatefulWidget {
  const ThemePicker({
    super.key,
    required this.initialColor,
    required this.initialMode,
    required this.onColorSelected,
    required this.onModeSelected,
  });

  final Color initialColor;
  final Mode initialMode;
  final ColorSelectedCallback onColorSelected;
  final ModeSelectedCallback onModeSelected;

  @override
  State<ThemePicker> createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker> {
  late Color _selectedColor;
  late Mode _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
    _selectedMode = widget.initialMode;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            min: 0,
            max: Color.values.length.toDouble() - 1,
            divisions: Color.values.length - 1,
            value: Color.values.indexOf(_selectedColor).toDouble(),
            onChanged: (value) {
              setState(() {
                _selectedColor = Color.values[value.toInt()];
                widget.onColorSelected(_selectedColor);
              });
            },
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _selectedMode = Mode.values[
                  (Mode.values.indexOf(_selectedMode) + 1) %
                      Mode.values.length];
              widget.onModeSelected(_selectedMode);
            });
          },
          icon: Icon(
            _selectedMode.toIconData(context),
          ),
        )
      ],
    );
  }
}

extension on Mode {
  IconData toIconData(BuildContext context) {
    switch (this) {
      case Mode.light:
        return Icons.light_mode;
      case Mode.dark:
        return Icons.dark_mode;
      case Mode.automatic:
        return MediaQuery.of(context).platformBrightness.toIconData();
    }
  }
}

extension on Brightness {
  IconData toIconData() {
    switch (this) {
      case Brightness.dark:
        return Icons.dark_mode_outlined;
      case Brightness.light:
        return Icons.light_mode_outlined;
    }
  }
}
