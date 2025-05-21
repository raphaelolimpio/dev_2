import 'package:flutter/material.dart';

enum InputTextSize { small, medium, large }

class InputTextValidatorViewModel {
  final InputTextSize size;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  bool password;
  final Widget? suffixIcon;
  final bool isEnabled;
  final String? Function(String?)? validator;

  InputTextValidatorViewModel({
    required this.size,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.password,
    this.suffixIcon,
    this.validator,
    required this.isEnabled,
  });
}
