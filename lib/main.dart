import 'package:courses/pages/LoginPage.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:courses/pages/courses/entry_page.dart';
import 'package:courses/pages/courses/topic_courses.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:courses/pages/authPage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBgIMiDfWszcjDrUOlFLQx7zmWP-52iywo",
          authDomain: "coursesnis-87b8f.firebaseapp.com",
          projectId: "coursesnis-87b8f",
          storageBucket: "coursesnis-87b8f.appspot.com",
          messagingSenderId: "402293224745",
          appId: "1:402293224745:web:da93d0c8695bdd3c027338",
          measurementId: "G-5P6MFPC2ZV",
      ));
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Courses NIS PTR",
      home: AuthPage(),
    // Login()
  ));
}

