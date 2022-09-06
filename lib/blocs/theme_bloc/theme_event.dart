import 'package:flutter/material.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class SetColorSeed extends ThemeEvent {
  final MaterialColor color;

  const SetColorSeed(this.color);
}
