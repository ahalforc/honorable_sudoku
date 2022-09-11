import 'package:honorable_sudoku/sudoku/sudoku.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SudokuLocalStorage {
  static const _difficultyKey = 'sudoku_difficulty';

  static Future<Difficulty> getDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    final difficulty = prefs.getString(_difficultyKey);
    return Difficulty.values.firstWhere(
      (v) => v.toValue() == difficulty,
      orElse: () => Difficulty.easy,
    );
  }

  static void setDifficulty(Difficulty difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_difficultyKey, difficulty.toValue());
  }
}

extension on Difficulty {
  String toValue() {
    switch (this) {
      case Difficulty.easy:
        return 'easy';
      case Difficulty.medium:
        return 'medium';
      case Difficulty.hard:
        return 'hard';
    }
  }
}
