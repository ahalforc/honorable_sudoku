import 'package:equatable/equatable.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';

abstract class SudokuEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeSudoku extends SudokuEvent {}

class NewGame extends SudokuEvent {
  final Difficulty difficulty;

  NewGame({required this.difficulty});

  @override
  List<Object?> get props => [difficulty];
}

class SetNumber extends SudokuEvent {
  final int index, value;

  SetNumber({required this.index, required this.value});

  @override
  List<Object?> get props => [index, value];
}

class EraseNumber extends SudokuEvent {
  final int index;

  EraseNumber({required this.index});

  @override
  List<Object?> get props => [index];
}
