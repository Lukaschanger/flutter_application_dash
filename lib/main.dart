import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_dash/contact.dart';
import 'package:flutter_application_dash/firebase_options.dart';
import 'package:flutter_application_dash/options.dart';
import 'auth_Gate.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Connou Dashboard",
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/home': (context) => const HomeScreen(),
        '/contact': (context) => ContactScreen(),
        '/options': (context) => OptionsScreen(),
      },
    );
  }
}
