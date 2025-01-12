import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';

class BasicTextFormField extends StatefulWidget {
  final String initialValue;
  final String hintText;
  final bool isPasswordField;
  final Widget? prefixIcon;

  const BasicTextFormField({
    required this.initialValue,
    required this.hintText,
    this.isPasswordField = false,
    this.prefixIcon,
    super.key,
  });

  @override
  State<BasicTextFormField> createState() => _BasicTextFormFieldState();
}

class _BasicTextFormFieldState extends State<BasicTextFormField> {
  var _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: !_isPasswordVisible,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          prefixIconColor: MyColors.purpleColor,
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: _suffixIcon(_isPasswordVisible),
                )
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: MyColors.hintColor.withOpacity(0.3),
            shadows: const [
              Shadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
              ),
            ],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyColors.purpleColorBorder,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyColors.purpleColorBorder,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyColors.purpleColorBorder,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyColors.purpleColorBorder,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(
          color: MyColors.purpleColor,
        ),
      ),
    );
  }
}

Widget _suffixIcon(bool isPasswordVisible) {
  return isPasswordVisible
      ? const Icon(Icons.visibility_outlined)
      : const Icon(Icons.visibility_off_outlined);
}
