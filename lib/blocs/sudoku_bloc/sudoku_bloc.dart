import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honorable_sudoku/blocs/sudoku_bloc.dart';
import 'package:honorable_sudoku/indexed_sudoku.dart';
import 'package:uuid/uuid.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  SudokuBloc() : super(SudokuState.empty()) {
    on<NewGame>(_onNewGame);
    on<SetNumber>(_onSetNumber);
    on<EraseNumber>(_onEraseNumber);
  }

  FutureOr<void> _onNewGame(
    NewGame event,
    Emitter<SudokuState> emit,
  ) async {
    final generator = IndexedSudoku.generate(
      emptySquares: event.emptySquares,
    );

    emit(
      SudokuState(
        id: const Uuid().v4(),
        size: generator.size,
        emptySquares: event.emptySquares,
        status: Status.none,
        values: generator.values,
        initialValueIndices: generator.initialValueIndices,
        guessedValues: const {},
        placeholderValues: const {},
      ),
    );
  }

  FutureOr<void> _onSetNumber(
    SetNumber event,
    Emitter<SudokuState> emit,
  ) {
    final guessedValues = Map.of(state.guessedValues);
    guessedValues[event.index] = event.value;
    emit(
      SudokuState(
        id: state.id,
        size: state.size,
        emptySquares: state.emptySquares,
        status: _getBoardStatus(guessedValues),
        values: state.values,
        initialValueIndices: state.initialValueIndices,
        guessedValues: guessedValues,
        placeholderValues: state.placeholderValues,
      ),
    );
  }

  FutureOr<void> _onEraseNumber(
    EraseNumber event,
    Emitter<SudokuState> emit,
  ) {
    final guessedValues = Map.of(state.guessedValues);
    guessedValues.remove(event.index);
    emit(
      SudokuState(
        id: state.id,
        size: state.size,
        emptySquares: state.emptySquares,
        status: state.status,
        values: state.values,
        initialValueIndices: state.initialValueIndices,
        guessedValues: guessedValues,
        placeholderValues: state.placeholderValues,
      ),
    );
  }

  Status _getBoardStatus(Map<int, int> guessedValues) {
    for (var i = 0; i < state.values.length; i++) {
      if (state.initialValueIndices.contains(i)) {
        // If this index was pre-set, then it's valid and we can continue.
        continue;
      } else if (guessedValues[i] == state.values[i]) {
        // If this index was guessed, and its value equals the board value, then we can continue.
        continue;
      }
      // If this was neither pre-set nor guessed, then the board is incomplete.
      // todo return Status.error if the guessed value cannot exist in that index.
      return Status.none;
    }
    return Status.complete;
  }
}
