import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;

  const BasicTextFormField({required this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(suffixIcon: Icon(Icons.add)),
      ),
    );
  }
}
