import 'package:courses/main.dart';
import 'package:courses/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/pages/courses/teacherCourses.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            String? userId = user?.uid;

            return FutureBuilder(
              future: FirebaseDatabase.instance.ref().child('users').child(userId!).get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.value != null && snapshot.connectionState == ConnectionState.done) {
                  dynamic userData = snapshot.data!.value;
                  String? role = userData['role'];
                  print(role);

                  if (role == 'Student') {
                    userRole = Roles.student;
                  } else if (role == 'Teacher') {
                    userRole = Roles.teacher;
                  } else if (role == 'Admin') {
                    userRole = Roles.admin;
                  }
                  return MainPage();

                } else {
                  return Center(
                    child: CircularProgressIndicator()
                  );
                }
              },
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}