import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_strings.dart';
import 'package:flutter_app/views/login/login_view.dart';
import 'package:flutter_app/views/widgets/basic_text_form_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/sign_in_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left_rounded,
                          color: MyColors.purpleColor,
                        ),
                        Text(
                          MyStrings.goBack,
                          style: TextStyle(
                            color: MyColors.purpleColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      MyStrings.signUp,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: MyColors.purpleColor,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 46),
              const Column(
                children: [
                  BasicTextFormField(
                    prefixIcon: Icon(MdiIcons.accountCircleOutline),
                    initialValue: '',
                    hintText: MyStrings.fullName,
                  ),
                  SizedBox(height: 40),
                  BasicTextFormField(
                    prefixIcon: Icon(MdiIcons.emailOutline),
                    initialValue: '',
                    hintText: MyStrings.emailShort,
                  ),
                  SizedBox(height: 40),
                  BasicTextFormField(
                    prefixIcon: Icon(MdiIcons.lockOutline),
                    initialValue: '',
                    hintText: MyStrings.password,
                    isPasswordField: true,
                  ),
                  SizedBox(height: 40),
                  BasicTextFormField(
                    prefixIcon: Icon(MdiIcons.lockOutline),
                    initialValue: '',
                    hintText: MyStrings.confirmPassword,
                    isPasswordField: true,
                  ),
                ],
              ),
              const SizedBox(height: 70),
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
                      ),
                    ),
                    child: const SignInButton(text: MyStrings.signUp),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MyStrings.haveAccount,
                    style: TextStyle(
                      color: MyColors.purpleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: Text(
                      MyStrings.signIn,
                      style: TextStyle(
                        color: MyColors.purpleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
