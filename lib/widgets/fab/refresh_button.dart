import 'package:flutter/material.dart';

typedef RefreshCallback = void Function();

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key, required this.onTap});

  final RefreshCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.refresh),
    );
  }
}
