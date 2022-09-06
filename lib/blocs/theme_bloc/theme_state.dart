import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final MaterialColor color;

  const ThemeState({required this.color});

  @override
  List<Object?> get props => [color];
}
