import 'package:flutter/material.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';

typedef DifficultySelectedCallback = void Function(Difficulty);

class DifficultyPicker extends StatefulWidget {
  const DifficultyPicker({
    super.key,
    required this.initialDifficulty,
    required this.onDifficultySelected,
  });

  final Difficulty initialDifficulty;
  final DifficultySelectedCallback onDifficultySelected;

  @override
  State<DifficultyPicker> createState() => _DifficultyPickerState();
}

class _DifficultyPickerState extends State<DifficultyPicker> {
  late Difficulty _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _selectedDifficulty = widget.initialDifficulty;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: Difficulty.values.length.toDouble() - 1,
      divisions: Difficulty.values.length - 1,
      value: Difficulty.values.indexOf(_selectedDifficulty).toDouble(),
      onChanged: (value) {
        setState(() {
          _selectedDifficulty = Difficulty.values[value.toInt()];
          widget.onDifficultySelected(_selectedDifficulty);
        });
      },
    );
  }
}
