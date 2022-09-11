import 'package:honorable_sudoku/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalStorage {
  static const _modeKey = 'theme_mode';
  static const _colorKey = 'theme_color';

  static Future<Mode> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_modeKey);
    return Mode.values.firstWhere(
      (v) => v.toValue() == mode,
      orElse: () => Mode.automatic,
    );
  }

  static void setMode(Mode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_modeKey, mode.toValue());
  }

  static Future<Color> getColor() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString(_colorKey);
    return Color.values.firstWhere(
      (v) => v.toValue() == color,
      orElse: () => Color.blue,
    );
  }

  static void setColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_colorKey, color.toValue());
  }
}

extension on Mode {
  String toValue() {
    switch (this) {
      case Mode.light:
        return 'light';
      case Mode.dark:
        return 'dark';
      case Mode.automatic:
        return 'automatic';
    }
  }
}

extension on Color {
  String toValue() {
    switch (this) {
      case Color.red:
        return 'red';
      case Color.orange:
        return 'orange';
      case Color.amber:
        return 'amber';
      case Color.yellow:
        return 'yellow';
      case Color.lightGreen:
        return 'lightGreen';
      case Color.green:
        return 'green';
      case Color.lightBlue:
        return 'lightBlue';
      case Color.blue:
        return 'blue';
      case Color.indigo:
        return 'indigo';
      case Color.purple:
        return 'purple';
    }
  }
}
