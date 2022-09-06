import 'package:equatable/equatable.dart';

abstract class SudokuEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewGame extends SudokuEvent {
  final int emptySquares;

  NewGame({required this.emptySquares});

  @override
  List<Object?> get props => [emptySquares];
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
