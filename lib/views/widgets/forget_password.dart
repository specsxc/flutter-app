import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          MyStrings.forgetPassword,
          style: TextStyle(
            fontSize: 15,
            color: MyColors.purpleColor,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),),
    );
  }
}
