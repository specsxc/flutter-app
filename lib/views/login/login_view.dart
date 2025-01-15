import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_images.dart';
import 'package:flutter_app/utils/my_preferences.dart';
import 'package:flutter_app/utils/my_strings.dart';
import 'package:flutter_app/views/home/home_view_copy.dart';
import 'package:flutter_app/views/register/register_view.dart';
import 'package:flutter_app/views/widgets/basic_text_form_field.dart';
import 'package:flutter_app/views/widgets/forget_password.dart';
import 'package:flutter_app/views/widgets/sign_in_button.dart';
import 'package:flutter_app/views/widgets/sign_in_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _emailError;
  String? _passwordError;

  final String _correctEmail = 'login123';
  final String _correctPassword = '123';

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_email == _correctEmail && _password == _correctPassword) {
        await MyPreferences.setLoggedIn(value: true);
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        setState(() {
          if (_email != _correctEmail) {
            _emailError = 'Not a valid email';
          }
          if (_password != _correctPassword) {
            _passwordError = 'Not a valid password';
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 62),
                  child: Image.asset(MyImages.logo),
                ),
                const TitleScreen(titleText: MyStrings.titleText),
                const SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      BasicTextFormField(
                        prefixIcon: const Icon(MdiIcons.accountCircleOutline),
                        errorText: _emailError,
                        hintText: MyStrings.email,
                        textShadows: const [
                          Shadow(
                            blurRadius: 8,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                          ),
                        ],
                        onChanged: (value) => _email = value.trim(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email or User Name cannot be empty';
                          } else if (_emailError != null) {
                            return _emailError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      BasicTextFormField(
                        prefixIcon: const Icon(MdiIcons.lockOutline),
                        errorText: _passwordError,
                        isPasswordField: true,
                        hintText: MyStrings.password,
                        onChanged: (value) => _password = value.trim(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (_passwordError != null) {
                            return _passwordError;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const ForgetPassword(),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: MyColors.whiteColor,
                        backgroundColor: MyColors.purpleFadeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const SignInButton(
                        text: MyStrings.signIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 202),
                Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
