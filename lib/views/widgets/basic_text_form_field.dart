import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_colors.dart';

class BasicTextFormField extends StatefulWidget {
  final String hintText;
  final bool isPasswordField;
  final Widget? prefixIcon;
  final List<Shadow>? textShadows;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;

  const BasicTextFormField({
    required this.hintText,
    this.isPasswordField = false,
    this.prefixIcon,
    this.textShadows,
    super.key,
    this.validator,
    this.onChanged,
    this.errorText,
  });

  @override
  State<BasicTextFormField> createState() => _BasicTextFormFieldState();
}

class _BasicTextFormFieldState extends State<BasicTextFormField> {
  var _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = !widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    return TextFormField(
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: MyColors.purpleColor,
        suffixIconColor: MyColors.blackColorSuffix.withOpacity(0.7),
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
          shadows: widget.textShadows,
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
            color: MyColors.redColorError,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyColors.redColorError,
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
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}

Widget _suffixIcon(bool isPasswordVisible) {
  return isPasswordVisible
      ? const Icon(Icons.visibility_outlined)
      : const Icon(Icons.visibility_off_outlined);
}
