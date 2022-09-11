import 'package:equatable/equatable.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';

enum Status { none, invalid, complete }

class SudokuState extends Equatable {
  final String id;
  final int size;
  final Difficulty difficulty;
  final Status status;

  final List<int> values;
  final Set<int> initialValueIndices;
  final Map<int, int> guessedValues;
  final Map<int, List<int>> placeholderValues;

  const SudokuState({
    required this.id,
    required this.size,
    required this.difficulty,
    required this.status,
    required this.values,
    required this.initialValueIndices,
    required this.guessedValues,
    required this.placeholderValues,
  });

  factory SudokuState.empty() => const SudokuState(
        id: '',
        size: 0,
        difficulty: Difficulty.easy,
        status: Status.none,
        values: [],
        initialValueIndices: {},
        guessedValues: {},
        placeholderValues: {},
      );

  @override
  List<Object?> get props => [
        id,
        size,
        difficulty,
        status,
        values,
        initialValueIndices,
        guessedValues,
        placeholderValues,
      ];

  int? getEffectiveValue(int index) {
    if (initialValueIndices.contains(index)) {
      return values[index];
    }
    return guessedValues[index];
  }
}
