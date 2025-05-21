import 'package:flutter/material.dart';

enum InputTextSize { small, medium, large }

enum InputTextType { string, phone }

class InputTextViewModel {
  final InputTextSize size;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isEnabled;
  final InputTextType inputType;

  InputTextViewModel({
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isEnabled = true,
    required this.size,
    required this.hintText,
    required this.controller,
    this.inputType = InputTextType.string,
  });
}
