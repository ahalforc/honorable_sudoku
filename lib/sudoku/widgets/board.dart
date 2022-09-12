import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';

class SudokuGameBoard extends StatelessWidget {
  const SudokuGameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SudokuBloc>().state;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cellSize = min(constraints.maxWidth / state.size - 2, 64.0);

        return Stack(
          children: [
            for (var i = 0; i < state.values.length; i++)
              Positioned(
                left: IndexedSudoku.getColumn(i, size: state.size) * cellSize +
                    (constraints.maxWidth - cellSize * state.size) / 2,
                top: IndexedSudoku.getRow(i, size: state.size) * cellSize +
                    (constraints.maxHeight - cellSize * state.size) / 2,
                width: cellSize,
                height: cellSize,
                child: NumberPicker(
                  initialNumber: state.guessedValues[i],
                  initialPlaceholders: state.placeholderValues[i],
                  onNumber: state.isReadOnly(i)
                      ? null
                      : (number) {
                          context
                              .read<SudokuBloc>()
                              .add(SetNumber(index: i, value: number));
                        },
                  onPlaceholder: state.isReadOnly(i)
                      ? null
                      : (placeholder) {
                          // context.read<SudokuBloc>().add(
                          //   SetPlaceholder(index: i, value: placeholder),
                          // );
                        },
                  child: Cell(
                    value: state.getEffectiveValue(i),
                    isFilled: IndexedSudoku.getBoxCheckeredFill(
                          i,
                          size: state.size,
                        ) ==
                        Checkered.filled,
                    isOutlined: state.status == Status.complete,
                    isBold: state.initialValueIndices.contains(i),
                    isLarge: cellSize >= 64,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
