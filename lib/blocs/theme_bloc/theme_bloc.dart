import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honorable_sudoku/blocs/theme_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(color: Colors.blue)) {
    on<SetColorSeed>(_onSetColorSeed);

    // todo read from shared preferences
  }

  FutureOr<void> _onSetColorSeed(SetColorSeed event, Emitter<ThemeState> emit) {
    // todo write to shared preferences
    emit(
      ThemeState(color: event.color),
    );
  }
}
