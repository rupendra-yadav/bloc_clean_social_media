import 'package:flutter/material.dart';

class TextFieldInputs extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPass;
  final TextInputType textInputKeyBoardType;
  const TextFieldInputs({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.textInputKeyBoardType,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    var inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(10.0),
      ),
      obscureText: isPass,
      keyboardType: textInputKeyBoardType,
    );
  }
}
