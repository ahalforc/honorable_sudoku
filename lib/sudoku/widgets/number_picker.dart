import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honorable_sudoku/sudoku/sudoku.dart';

class NumberPicker extends StatelessWidget {
  const NumberPicker({
    super.key,
    required this.index,
    required this.isReadOnly,
    required this.child,
  });

  final int index;
  final bool isReadOnly;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isReadOnly
          ? null
          : () {
              final bloc = context.read<SudokuBloc>();
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: SizedBox(
                    width: 68,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      children: [
                        for (var i = 1; i <= 9; i++)
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              bloc.add(SetNumber(index: index, value: i));
                            },
                            child: Text('$i'),
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Navigator.of(context).pop();
                            bloc.add(EraseNumber(index: index));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
      child: child,
    );
  }
}
