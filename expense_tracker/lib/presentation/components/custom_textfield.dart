import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool keyBoard;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String validation;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.validation = '',
    this.maxLines = 1,
    this.keyBoard = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoard ? TextInputType.number : TextInputType.text,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: hintText,
        alignLabelWithHint: maxLines > 1,

        // hintText: hintText,
        border: const OutlineInputBorder(
          // borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 143, 143, 143),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          // borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 143, 143, 143),
          ),
        ),
      ),
      textAlignVertical: TextAlignVertical.top,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
