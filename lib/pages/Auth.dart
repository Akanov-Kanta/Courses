import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/LoginPage.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:courses/pages/teacherCourses.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return teacherCourses();
          }

          // user is NOT logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}