import 'package:flutter/material.dart';

typedef EmptySpacesSelectedCallback = void Function(int);

class EmptySpacesPicker extends StatefulWidget {
  const EmptySpacesPicker({
    super.key,
    required this.initialEmptySpaces,
    required this.onEmptySpacesSelected,
  });

  final int initialEmptySpaces;
  final void Function(int) onEmptySpacesSelected;

  @override
  State<EmptySpacesPicker> createState() => _EmptySpacesPickerState();
}

class _EmptySpacesPickerState extends State<EmptySpacesPicker> {
  static const _min = 1, _max = 50;

  late int _selectedEmptySpaces;

  @override
  void initState() {
    super.initState();
    _selectedEmptySpaces = widget.initialEmptySpaces.isWithin(_min, _max)
        ? widget.initialEmptySpaces
        : _min;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: _min.toDouble(),
      max: _max.toDouble(),
      divisions: _max - _min,
      value: _selectedEmptySpaces.toDouble(),
      onChanged: (value) {
        setState(() {
          _selectedEmptySpaces = value.round();
          widget.onEmptySpacesSelected(_selectedEmptySpaces);
        });
      },
    );
  }
}

extension on int {
  bool isWithin(int min, int max) => min <= this && this <= max;
}
