import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';

class TitleScreen extends StatelessWidget {
  final String titleText;
  const TitleScreen({required this.titleText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        titleText,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: MyColors.purpleColor,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
