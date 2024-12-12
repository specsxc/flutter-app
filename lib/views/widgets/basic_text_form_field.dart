import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;

  const BasicTextFormField({required this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(initialValue: initialValue);
  }
}
