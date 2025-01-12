import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_images.dart';
import 'package:flutter_app/utils/my_strings.dart';
import 'package:flutter_app/views/register/register_view.dart';
import 'package:flutter_app/views/widgets/basic_text_form_field.dart';
import 'package:flutter_app/views/widgets/forget_password.dart';
import 'package:flutter_app/views/widgets/sign_in_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
              Padding(
                padding: const EdgeInsets.only(top: 62),
                child: Image.asset(MyImages.logo),
              ),
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
                      ),
                    ),
                    child: const Text(
                      MyStrings.signIn,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 202),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MyStrings.noAccount,
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
                            builder: (context) => const RegisterView(),
                          ),
                        );
                      },
                      child: Text(
                        MyStrings.signUp,
                        style: TextStyle(
                          color: MyColors.purpleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
