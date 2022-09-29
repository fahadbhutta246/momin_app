import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momin_app/screens/auth.dart';
import 'package:momin_app/screens/tab_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required Map<String, Widget Function(dynamic ctx)> routes}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var authHandler = Auth();



  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple[100],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 7,
                    blurRadius: 10,
                  )
                ]
            ),
            width: double.infinity,
            height: 400,
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email',
                    labelStyle: TextStyle(
                      fontFamily: 'Architect',
                    ),
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Enter Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Architect',
                      ),
                      icon: Icon(Icons.text_rotation_angledown)
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),

                TextButton(
                  onPressed: () {
                    authHandler.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                    .then((User? user) {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/main'));
                    }).catchError((e) => print(e));
                  },
                  child: const Text('SIGN IN'),
                ),
                const SizedBox(
                  height: 20,
                ),


                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
