import 'package:flutter/material.dart';

typedef ColorSelectedCallback = void Function(MaterialColor);

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  final MaterialColor initialColor;
  final void Function(MaterialColor) onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  static const _availableColors = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  late MaterialColor _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = _availableColors.contains(widget.initialColor)
        ? widget.initialColor
        : _availableColors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: _availableColors.length.toDouble() - 1,
      divisions: _availableColors.length - 1,
      value: _availableColors.indexOf(_selectedColor).toDouble(),
      onChanged: (value) {
        setState(() {
          _selectedColor = _availableColors[value.toInt()];
          widget.onColorSelected(_selectedColor);
        });
      },
    );
  }
}
