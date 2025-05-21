import 'package:dev/desygn_system/components/input/input_text/input_text_view_model.dart';
import 'package:dev/desygn_system/shared/color/colors.dart';
import 'package:dev/desygn_system/shared/style/style.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final InputTextViewModel viewModel;

  const InputText({super.key, required this.viewModel});

  @override
  InputTextState createState() => InputTextState();

  static Widget instantiate(InputTextViewModel viewModel) {
    return InputText(viewModel: viewModel);
  }
}

class InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 20.0;
    double verticalPadding = 15.0;
    BorderRadius borderRadius = BorderRadius.circular(4);
    BorderSide borderSide = const BorderSide(color: kGray100);
    TextStyle textStyle = textFieldStyle;

    switch (widget.viewModel.size) {
      case InputTextSize.small:
        horizontalPadding = 16.0;
        verticalPadding = 8.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: kGray100);
        textStyle = smallStyle;
        break;
      case InputTextSize.medium:
        horizontalPadding = 24.0;
        verticalPadding = 12.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: kGray100);
        textStyle = normalStyle;
        break;
      case InputTextSize.large:
        horizontalPadding = 32.0;
        verticalPadding = 12.0;
        borderRadius = BorderRadius.circular(4);
        borderSide = const BorderSide(color: kGray100);
        textStyle = normalStyle;
    }

    Icon? _getIcon(TextInputType type) {
      switch (type) {
        case TextInputType.name:
          return const Icon(Icons.person);
        case TextInputType.phone:
          return const Icon(Icons.phone);
        case TextInputType.emailAddress:
          return const Icon(Icons.email);
        case TextInputType.visiblePassword:
          return const Icon(Icons.lock);
        default:
          return null;
      }
    }

    InputDecoration decoration = InputDecoration(
      labelText: widget.viewModel.hintText,
      prefixIcon: _getIcon(widget.viewModel.keyboardType),
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kGray200, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kRed200, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kRed200, width: 2.0),
      ),
    );

    return TextField(
      controller: widget.viewModel.controller,
      decoration: decoration,
      style: textStyle,
      obscureText: widget.viewModel.obscureText,
      keyboardType: widget.viewModel.keyboardType,
      enabled: widget.viewModel.isEnabled,
    );
  }
}
