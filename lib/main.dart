import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';
import 'package:honorable_sudoku/theme/theme.dart';
import 'package:honorable_sudoku/widgets/fab/settings_fab.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppProviders(
      child: AppRoot(
        child: AppBody(),
      ),
    );
  }
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SudokuBloc()
            ..add(
              InitializeSudoku(),
            ),
        ),
        BlocProvider(
          create: (_) => ThemeBloc()
            ..add(
              InitializeTheme(),
            ),
        ),
      ],
      child: child,
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honorable Sudoku',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: context.watch<ThemeBloc>().state.color.toMaterialColor(),
          brightness: context.watch<ThemeBloc>().state.mode.toBrightness(),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.bitter(),
        ),
        useMaterial3: true,
      ),
      home: child,
    );
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SudokuGameBoard(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SettingsFab(
        initialColor: context.watch<ThemeBloc>().state.color,
        onColor: (color) {
          context.read<ThemeBloc>().add(SetColorSeed(color));
        },
        initialMode: context.watch<ThemeBloc>().state.mode,
        onMode: (mode) {
          context.read<ThemeBloc>().add(SetMode(mode));
        },
        initialDifficulty: context.watch<SudokuBloc>().state.difficulty,
        onDifficulty: (difficulty) {
          context.read<SudokuBloc>().add(NewGame(difficulty: difficulty));
        },
        onRefresh: () {
          final bloc = context.read<SudokuBloc>();
          bloc.add(NewGame(difficulty: bloc.state.difficulty));
        },
      ),
    );
  }
}

extension on Color {
  MaterialColor toMaterialColor() {
    switch (this) {
      case Color.red:
        return Colors.red;
      case Color.orange:
        return Colors.orange;
      case Color.amber:
        return Colors.amber;
      case Color.yellow:
        return Colors.yellow;
      case Color.lightGreen:
        return Colors.lightGreen;
      case Color.green:
        return Colors.green;
      case Color.lightBlue:
        return Colors.lightBlue;
      case Color.blue:
        return Colors.blue;
      case Color.indigo:
        return Colors.indigo;
      case Color.purple:
        return Colors.purple;
    }
  }
}

extension on Mode {
  Brightness toBrightness() {
    switch (this) {
      case Mode.light:
        return Brightness.light;
      case Mode.dark:
        return Brightness.dark;
      case Mode.automatic:
        return SchedulerBinding.instance.window.platformBrightness;
    }
  }
}
