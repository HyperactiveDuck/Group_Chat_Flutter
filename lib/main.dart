import 'package:flutter/material.dart';
import 'package:flash_flutter/screens/welcome_screen.dart';
import 'package:flash_flutter/screens/login_screen.dart';
import 'package:flash_flutter/screens/registration_screen.dart';
import 'package:flash_flutter/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const GroupChat());
}

class GroupChat extends StatelessWidget {
  const GroupChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        hintColor: Colors.black54,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: WelcomeScreenActual.id,
      routes: {
        WelcomeScreenActual.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
