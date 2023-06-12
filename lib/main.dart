
import 'package:courses/pages/LoginPage.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Courses NIS PTR",
      home: LoginPage()
    // Login()
  ));
}

