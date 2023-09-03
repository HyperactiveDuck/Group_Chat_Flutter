// ignore_for_file: sized_box_for_whitespace

import 'package:flash_flutter/constants.dart';
import 'package:flash_flutter/screens/login_screen.dart';
import 'package:flash_flutter/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_flutter/widgets/landing_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({
    super.key,
  });

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0; // 1.0 means normal animation speed.
    return Scaffold(
      backgroundColor: kSeconderycolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60,
                    child: logoImage,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      kAppTitle,
                      textStyle: animatedTextStyle,
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false,
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Hero(
              tag: 'login',
              child: LandingButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                buttonColor: kPrimaryColor,
                buttonText: 'Log In',
              ),
            ),
            Hero(
              tag: 'register',
              child: LandingButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                buttonColor: kPrimaryColor,
                buttonText: 'Register',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
