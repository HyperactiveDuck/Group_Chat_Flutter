// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously
import 'package:flash_flutter/screens/chat_screen.dart';
import 'package:flash_flutter/widgets/text_input_widget.dart';
import 'package:flash_flutter/widgets/landing_button.dart';
import 'package:flash_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSeconderycolor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: logoImage,
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextInputWidget(
                isEmail: true,
                onChanged: (value) {
                  email = value;
                },
                hintText: emailHintText,
                isPassword: false,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextInputWidget(
                isEmail: false,
                onChanged: (value) {
                  password = value;
                },
                hintText: passwordHintText,
                isPassword: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              Hero(
                tag: 'login',
                child: LandingButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    if (email.isEmpty || password.isEmpty) {
                      setState(() {
                        error = 'Please enter your email and password';
                        showSpinner = false;
                      });
                      return;
                    } else {
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          error = 'Invalid email or password';
                          showSpinner = false;
                        });
                      }
                    }
                  },
                  buttonColor: kPrimaryColor,
                  buttonText: 'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
