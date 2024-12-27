import 'package:market/components/my_button.dart';
import 'package:market/components/my_textfield.dart';
import 'package:market/helper/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // logo
                    Icon(
                      Icons.person,
                      size: 80,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
          
                    const SizedBox(
                      height: 25,
                    ),
          
                    // app name
                    const Text(
                      "M I N I M A L",
                      style: TextStyle(fontSize: 20),
                    ),
          
                    const SizedBox(
                      height: 50,
                    ),
          
                    // email textfield
                    MyTextfield(
                        hintText: "Email",
                        obscureText: false,
                        controller: emailController),
          
                    const SizedBox(
                      height: 10,
                    ),
          
                    // password textfield
                    MyTextfield(
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController),
          
                    const SizedBox(
                      height: 10,
                    ),
          
                    // forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot password?",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ],
                    ),
          
                    const SizedBox(
                      height: 25,
                    ),
          
                    // sign in button
                    MyButton(text: "Login", onTap: login),
          
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
