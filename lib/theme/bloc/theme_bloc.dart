import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honorable_sudoku/theme/theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          const ThemeState(
            mode: Mode.automatic,
            color: Color.blue,
          ),
        ) {
    on<InitializeTheme>(_onInitializeTheme);
    on<SetMode>(_onSetMode);
    on<SetColorSeed>(_onSetColorSeed);
  }

  @override
  void onTransition(Transition<ThemeEvent, ThemeState> transition) {
    super.onTransition(transition);
    ThemeLocalStorage.setMode(transition.nextState.mode);
    ThemeLocalStorage.setColor(transition.nextState.color);
  }

  FutureOr<void> _onInitializeTheme(
      InitializeTheme event, Emitter<ThemeState> emit) async {
    emit(
      ThemeState(
        mode: await ThemeLocalStorage.getMode(),
        color: await ThemeLocalStorage.getColor(),
      ),
    );
  }

  FutureOr<void> _onSetMode(SetMode event, Emitter<ThemeState> emit) {
    emit(
      ThemeState(
        mode: event.mode,
        color: state.color,
      ),
    );
  }

  FutureOr<void> _onSetColorSeed(SetColorSeed event, Emitter<ThemeState> emit) {
    emit(
      ThemeState(
        mode: state.mode,
        color: event.color,
      ),
    );
  }
}
