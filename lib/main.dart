import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:momin_app/screens/auth_page.dart';
import 'package:momin_app/screens/items_availabe.dart';
import 'package:momin_app/screens/my_info.dart';
import 'package:momin_app/screens/tab_screen.dart';
import 'package:momin_app/widgets/add_form.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Momin App",
      theme: ThemeData(
          primaryColor: Colors.deepOrange[600],
          fontFamily: 'Alice',
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.orangeAccent)),
      // home: const AuthPage(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const AuthPage(),
        '/release': (ctx) => const Card(),
        '/mine': (ctx) => const MyInfoScreen(),
        '/add': (ctx) => const AddForm(),
        '/main': (ctx) => const TabScreen(),
        '/items': (ctx) => const ItemsAvailable(),
      },
    );
  }
}
