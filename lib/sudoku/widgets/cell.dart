import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    this.value,
    required this.isFilled,
    required this.isOutlined,
    required this.isBold,
    required this.isLarge,
  });

  final int? value;
  final bool isFilled, isOutlined, isBold, isLarge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: isOutlined ? Colors.green : colorScheme.onBackground,
        ),
        borderRadius: BorderRadius.circular(4),
        color: isFilled ? colorScheme.primary.withOpacity(0.2) : null,
      ),
      child: Text(
        value?.toString() ?? '',
        style:
            (isLarge ? textTheme.titleLarge : textTheme.titleSmall)?.copyWith(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
