import 'package:market/auth/auth.dart';
import 'package:market/router/router.dart';
import 'package:flutter/material.dart';
import 'package:market/firebase_options.dart';
import 'package:market/theme/dark_mode.dart';
import 'package:market/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const AuthPage(),
      routes: routes,
    );
  }

}
