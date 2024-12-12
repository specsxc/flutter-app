import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_images.dart';
import 'package:flutter_app/views/register/register_view.dart';
import 'package:flutter_app/views/widgets/basic_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool boolValue = false;

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
              _signInText(boolValue),
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
                  setState(() {
                    boolValue = !boolValue;
                  });
                },
              ),
              const BasicTextFormField(
                initialValue: 'Hello',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signInText(bool boolValue) {
  return Text(
    'Sign in $boolValue',
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: MyColors.purpleColor,
    ),
  );
}
