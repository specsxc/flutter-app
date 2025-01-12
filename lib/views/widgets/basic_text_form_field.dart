import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';

import 'package:flutter_app/utils/my_images.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;

  const BasicTextFormField({required this.initialValue, super.key, required InputDecoration decoration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.account_circle),
            suffixIcon: Image.asset(MyImages.vector),
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: MyColors.purpleColorBorder,
                width: 2,
            ),
        ),),
      ),
    );
  }
}
