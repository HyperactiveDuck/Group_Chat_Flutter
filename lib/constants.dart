import 'package:flutter/material.dart';

TextStyle kSendButtonTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

Color kPrimaryColor = Colors.black;
Color kSeconderycolor = Colors.grey;
Color kThirdColor = const Color.fromRGBO(134, 142, 187, 1);
Color kFourthColor = const Color.fromRGBO(122, 113, 67, 1);
Color kFifthColor = const Color.fromRGBO(172, 158, 116, 1);
Color kSixthColor = const Color.fromARGB(255, 146, 127, 214);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

BoxDecoration kMessageContainerDecoration = BoxDecoration(
  color: Colors.white54,
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);

const backgroundColor = Color.fromARGB(136, 94, 94, 94);
const Image logoImage = Image(
  image: AssetImage('assets/images/logo.png'),
);

const TextStyle animatedTextStyle = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w900,
);

TextStyle inputTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.w900,
);

const String kAppTitle = 'Group Chat';
const String emailHintText = 'Enter your email';
const String passwordHintText = 'Enter your password';
InputDecoration kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kSixthColor, width: 2.0),
    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
  ),
);
