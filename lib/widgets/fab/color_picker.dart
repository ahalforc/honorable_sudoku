import 'package:flutter/material.dart' hide Color;
import 'package:honorable_sudoku/theme/theme.dart';

typedef ColorSelectedCallback = void Function(Color);

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  final Color initialColor;
  final ColorSelectedCallback onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
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
    );
  }
}
