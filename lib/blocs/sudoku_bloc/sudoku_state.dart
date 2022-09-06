import 'package:equatable/equatable.dart';

enum Status { none, invalid, complete }

class SudokuState extends Equatable {
  final String id;
  final int size;
  final int emptySquares;
  final Status status;

  final List<int> values;
  final Set<int> initialValueIndices;
  final Map<int, int> guessedValues;
  final Map<int, List<int>> placeholderValues;

  const SudokuState({
    required this.id,
    required this.size,
    required this.emptySquares,
    required this.status,
    required this.values,
    required this.initialValueIndices,
    required this.guessedValues,
    required this.placeholderValues,
  });

  factory SudokuState.empty() => const SudokuState(
        id: '',
        size: 0,
        emptySquares: 0,
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
        emptySquares,
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
