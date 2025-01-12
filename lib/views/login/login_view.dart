import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_images.dart';
import 'package:flutter_app/utils/my_strings.dart';
import 'package:flutter_app/views/register/register_view.dart';
import 'package:flutter_app/views/widgets/basic_text_form_field.dart';
import 'package:flutter_app/views/widgets/forget_password.dart';
import 'package:flutter_app/views/widgets/sign_in_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/my_colors.dart';

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
              const TitleScreen(titleText: MyStrings.titleText),
              const SizedBox(height: 46),
              const BasicTextFormField(
                prefixIcon: Icon(MdiIcons.accountCircleOutline),
                initialValue: '',
                hintText: MyStrings.email,
              ),
              const SizedBox(height: 40),
              const BasicTextFormField(
                prefixIcon: Icon(MdiIcons.lockOutline),
                initialValue: '',
                isPasswordField: true,
                hintText: MyStrings.password,
              ),
              const SizedBox(height: 40),
              const ForgetPassword(),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyColors.whiteColor,
                      backgroundColor: MyColors.purpleFadeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                    ),),
                    child: const Text(MyStrings.signIn),
                  ),
                ),
              ),
              GestureDetector(
                child: const Text('Sign Up'),
                onTap: () {
                  setState(() {
                    boolValue = !boolValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
