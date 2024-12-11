import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_images.dart';
import 'package:flutter_app/views/register/register_view.dart';

/// Login view
class LoginView extends StatelessWidget {
  /// Login view key
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 62),
              Image.asset(MyImages.logo),
              _signInText('Sign in'),
              ElevatedButton(
                child: const Text('Open route'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: const Text('Sign Up'),
                onTap: () {
                  print('xxx1');
                  print('xxx2');
                },
                onDoubleTap: () => print('clicked twice'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signInText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: MyColors.purpleColor,
    ),
  );
}
