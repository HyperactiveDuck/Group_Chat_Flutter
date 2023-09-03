import 'package:flutter/material.dart';
import 'package:flash_flutter/constants.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.isPassword,
    required this.isEmail,
  });
  final bool isEmail;
  final bool isPassword;
  final void Function(String) onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kPrimaryColor,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      textAlign: TextAlign.center,
      obscureText: isPassword,
      style: inputTextStyle,
      onChanged: onChanged,
      decoration: kInputDecoration.copyWith(hintText: hintText),
    );
  }
}
