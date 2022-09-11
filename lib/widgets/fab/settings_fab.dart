import 'dart:math';

import 'package:flutter/material.dart' hide RefreshCallback, Color;
import 'package:honorable_sudoku/sudoku/sudoku.dart';
import 'package:honorable_sudoku/theme/theme.dart';
import 'package:honorable_sudoku/widgets/fab/color_picker.dart';
import 'package:honorable_sudoku/widgets/fab/difficulty_picker.dart';
import 'package:honorable_sudoku/widgets/fab/refresh_button.dart';

class SettingsFab extends StatefulWidget {
  const SettingsFab({
    super.key,
    required this.initialColor,
    required this.onColor,
    required this.initialDifficulty,
    required this.onDifficulty,
    required this.onRefresh,
  });

  final Color initialColor;
  final ColorSelectedCallback onColor;

  final Difficulty initialDifficulty;
  final DifficultySelectedCallback onDifficulty;

  final RefreshCallback onRefresh;

  @override
  State<SettingsFab> createState() => _SettingsFabState();
}

class _SettingsFabState extends State<SettingsFab> {
  var _isOpened = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: _isOpened ? _buildSettings() : _buildFab(),
    );
  }

  Widget _buildSettings() {
    return _PopupContainer(
      children: [
        ColorPicker(
          initialColor: widget.initialColor,
          onColorSelected: widget.onColor,
        ),
        DifficultyPicker(
          initialDifficulty: widget.initialDifficulty,
          onDifficultySelected: widget.onDifficulty,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _isOpened = false),
            ),
            RefreshButton(
              onTap: widget.onRefresh,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: () => setState(() => _isOpened = !_isOpened),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: const Icon(Icons.settings),
    );
  }
}

class _PopupContainer extends StatelessWidget {
  const _PopupContainer({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final width = min(
      MediaQuery.of(context).size.width - 20,
      400.0,
    );
    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
