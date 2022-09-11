import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honorable_sudoku/sudoku/facades/sudoku_local_storage.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';
import 'package:uuid/uuid.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  SudokuBloc() : super(SudokuState.empty()) {
    on<InitializeSudoku>(_onInitializeSudoku);
    on<NewGame>(_onNewGame);
    on<SetNumber>(_onSetNumber);
    on<EraseNumber>(_onEraseNumber);
  }

    @override
  void onTransition(Transition<SudokuEvent, SudokuState> transition) {
    super.onTransition(transition);
    if (transition.currentState.difficulty != transition.nextState.difficulty) {
      SudokuLocalStorage.setDifficulty(transition.nextState.difficulty);
    }
  }

  FutureOr<void> _onInitializeSudoku(
    InitializeSudoku event,
    Emitter<SudokuState> emit,
  ) async {
    final difficulty = await SudokuLocalStorage.getDifficulty();
    add(NewGame(difficulty: difficulty));
  }

  FutureOr<void> _onNewGame(
    NewGame event,
    Emitter<SudokuState> emit,
  ) async {
    final generator = IndexedSudoku.generate(
      difficulty: event.difficulty,
    );

    emit(
      SudokuState(
        id: const Uuid().v4(),
        size: generator.size,
        difficulty: event.difficulty,
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
        difficulty: state.difficulty,
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
        difficulty: state.difficulty,
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
