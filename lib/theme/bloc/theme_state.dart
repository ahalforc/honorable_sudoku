import 'package:equatable/equatable.dart';
import 'package:honorable_sudoku/theme/theme.dart';

class ThemeState extends Equatable {
  final Mode mode;
  final Color color;

  const ThemeState({
    required this.mode,
    required this.color,
  });

  @override
  List<Object?> get props => [
        mode,
        color,
      ];
}
