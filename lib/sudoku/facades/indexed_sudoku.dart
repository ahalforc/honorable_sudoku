import 'dart:math';

import 'package:honorable_sudoku/sudoku/sudoku.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart' as dep;

/// Represents whether a cell should be filled or not to help with visual clarity.
enum Checkered { empty, filled }

/// Encapsulates logic related to an index-based Sudoku puzzle.
///
/// Index-based means that the underlying data is represented as a list of values
/// where 0 is the top left of the Sudoku and size^2-1 is the bottom right.
class IndexedSudoku {
  IndexedSudoku.generate({
    required Difficulty difficulty,
  }) {
    final generator =
        dep.SudokuGenerator(emptySquares: difficulty.emptySquares);
    final unsolved = generator.newSudoku, solved = generator.newSudokuSolved;

    for (var i = 0; i < size * size; i++) {
      final row = getRow(i, size: size), column = getColumn(i, size: size);

      // capture the cell's actual value
      values.add(solved[row][column]);

      // capture the cell's pre-determined value
      if (unsolved[row][column] > 0) {
        initialValueIndices.add(i);
      }
    }
  }

  int get size => 9;

  final _values = <int>[];
  List<int> get values => _values;

  final _initialValueIndices = <int>{};
  Set<int> get initialValueIndices => _initialValueIndices;

  /// [index] - the position of the Sudoku cell
  /// [size] - the width/height of the Sudoku
  ///
  /// Returns the row index of [index].
  /// For example, a 9x9 Sudoku with index 18 returns row 2.
  static int getRow(int index, {required int size}) => (index / size).floor();

  /// [index] - the position of the Sudoku cell
  /// [size] - the width/height of the Sudoku
  ///
  /// Returns the column index of [index].
  /// For example, a 9x9 Sudoku with index 10 returns column 1.
  static int getColumn(int index, {required int size}) => index % size;

  /// [size] - the width/height of the Sudoku
  ///
  /// Returns the width/height of a box group internal to the Sudoku.
  static int getBoxSize(int size) => sqrt(size).floor();

  /// [index] - the position of the Sudoku cell
  /// [size] - the width/height of the Sudoku
  ///
  /// Returns the row index of the encapsulating box of [index].
  /// For example, a 9x9 Sudoku has row indices of 0, 1, and 2.
  static int getBoxRow(int index, {required int size}) =>
      (getColumn(index, size: size) / getBoxSize(size)).floor();

  /// [index] - the position of the Sudoku cell
  /// [size] - the width/height of the Sudoku
  ///
  /// Returns the column index of the encapsulating box of [index].
  /// For example, a 9x9 Sudoku has column indices of 0, 1, and 2.
  static int getBoxColumn(int index, {required int size}) =>
      (getRow(index, size: size) / getBoxSize(size)).floor();

  /// [index] - the position of the Sudoku cell
  /// [size] - the width/height of the Sudoku
  ///
  /// Returns whether or not the given index should be highlighted as part
  /// of a "checkered" pattern. This is purely cosmetic.
  static Checkered getBoxCheckeredFill(int index, {required int size}) {
    final boxRow = getBoxRow(index, size: size);
    final boxColumn = getBoxColumn(index, size: size);
    return (boxColumn + boxRow) % 2 == 0 ? Checkered.empty : Checkered.filled;
  }
}

extension on Difficulty {
  int get emptySquares {
    switch (this) {
      case Difficulty.easy:
        return 35;
      case Difficulty.medium:
        return 47;
      case Difficulty.hard:
        return 50;
    }
  }
}
