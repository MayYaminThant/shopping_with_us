import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? text;
  final double? fontSize;

  const ErrorText({Key? key, this.text, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: Colors.red, fontSize: fontSize ?? 16),
    );
  }
}
