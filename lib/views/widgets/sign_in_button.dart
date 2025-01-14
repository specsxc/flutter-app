import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;

  const SignInButton({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
