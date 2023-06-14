import 'package:courses/const/constants.dart';
import 'package:courses/pages/LoginPage.dart';
import 'package:courses/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/schedule.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:courses/Auth.dart';
import 'package:courses/pages/users_page.dart';

enum Roles {student, teacher, admin}
Roles userRole = Roles.admin;

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBgIMiDfWszcjDrUOlFLQx7zmWP-52iywo",
        authDomain: "coursesnis-87b8f.firebaseapp.com",
        databaseURL: "https://coursesnis-87b8f-default-rtdb.europe-west1.firebasedatabase.app",
        projectId: "coursesnis-87b8f",
        storageBucket: "coursesnis-87b8f.appspot.com",
        messagingSenderId: "402293224745",
        appId: "1:402293224745:web:da93d0c8695bdd3c027338",
        measurementId: "G-5P6MFPC2ZV",
      ));
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Courses NIS PTR",
      theme: ThemeData(fontFamily: 'Poppins'),
      home: AuthPage(),
    // Login()
  ));
}

