// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously
import 'package:flash_flutter/screens/chat_screen.dart';
import 'package:flash_flutter/widgets/text_input_widget.dart';
import 'package:flash_flutter/widgets/landing_button.dart';
import 'package:flash_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
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
                tag: 'register',
                child: LandingButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    if (email == '' || password == '') {
                      showSpinner = false;
                      setState(() {
                        error = 'Email or password is empty';
                      });
                    } else {
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, ChatScreen.id);

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        switch (e.toString()) {
                          case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
                            setState(() {
                              error =
                                  'The email address is already in use by another account.';
                              showSpinner = false;
                            });
                          case '[firebase_auth/invalid-email] The email address is badly formatted.':
                            setState(() {
                              error = 'The email address is badly formatted.';
                              showSpinner = false;
                            });
                          case '[firebase_auth/weak-password] Password should be at least 6 characters':
                            setState(() {
                              error =
                                  'Password should be at least 6 characters';
                              showSpinner = false;
                            });
                          case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
                            setState(() {
                              error =
                                  'We have blocked all requests from this device due to unusual activity. Try again later.';
                              showSpinner = false;
                            });
                          case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                            setState(() {
                              error =
                                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
                              showSpinner = false;
                            });

                            break;
                          default:
                        }
                      }
                    }
                  },
                  buttonColor: kPrimaryColor,
                  buttonText: 'Register',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
