import 'package:flutter/material.dart';

typedef NumberSelectedCallback = void Function(int);
typedef PlaceholderSelectedCallback = void Function(int);

class NumberPicker extends StatelessWidget {
  const NumberPicker({
    super.key,
    required this.initialNumber,
    required this.initialPlaceholders,
    required this.onNumber,
    required this.onPlaceholder,
    required this.child,
  });

  final int? initialNumber;
  final List<int>? initialPlaceholders;
  final NumberSelectedCallback? onNumber;
  final PlaceholderSelectedCallback? onPlaceholder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      enabled: onNumber != null && onPlaceholder != null,
      color: Theme.of(context).colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      initialValue: initialNumber,
      itemBuilder: (context) => [
        for (var i = 1; i <= 9; i++)
          PopupMenuItem(
            value: i,
            child: Text('$i'),
          )
      ],
      onSelected: (value) => onNumber?.call(value),
      child: child,
    );
  }
}
