import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:momin_app/screens/auth.dart';
import 'package:momin_app/screens/tab_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var authHandler = Auth();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Map<String, signInWithEmailAndPassword>




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: const Text('AUTHENTICATE YOURSELF'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              // backgroundBlendMode: BlendMode.color,
                borderRadius: BorderRadius.circular(38),
                color: Colors.teal,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 25,
                    blurRadius: 25,
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
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PT Sans',
                    ),
                    icon: Icon(Icons.email,color: Colors.white,),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PT Sans',
                      ),
                      icon: Icon(Icons.text_rotation_angledown,color: Colors.white,)
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
                      Navigator.pushNamed(context, '/main');
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TabScreen()  ));
                    }).catchError((e) => print(e));
                  },
                  child: const Text('Way To Shop',
                  style: TextStyle(color: Colors.white) ,
                  ),
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
