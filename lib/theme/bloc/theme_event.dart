import 'package:honorable_sudoku/theme/theme.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class InitializeTheme extends ThemeEvent {}

class SetMode extends ThemeEvent {
  final Mode mode;
  const SetMode(this.mode);
}

class SetColorSeed extends ThemeEvent {
  final Color color;
  const SetColorSeed(this.color);
}
