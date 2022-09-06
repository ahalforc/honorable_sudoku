import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honorable_sudoku/blocs/sudoku_bloc.dart';
import 'package:honorable_sudoku/blocs/theme_bloc.dart';
import 'package:honorable_sudoku/widgets/board/sudoku_game_board.dart';
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
              NewGame(emptySquares: 50),
            ),
        ),
        BlocProvider(
          create: (_) => ThemeBloc(),
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
          seedColor: context.watch<ThemeBloc>().state.color,
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
        initialEmptySpaces: context.watch<SudokuBloc>().state.emptySquares,
        onEmptySpaces: (emptySpaces) {
          context.read<SudokuBloc>().add(NewGame(emptySquares: emptySpaces));
        },
        onRefresh: () {
          final bloc = context.read<SudokuBloc>();
          bloc.add(NewGame(emptySquares: bloc.state.emptySquares));
        },
      ),
    );
  }
}
