import 'package:courses/main.dart';
import 'package:courses/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:courses/pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses/pages/courses/teacherCourses.dart';
import 'package:courses/utils.dart';

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
          if (Authcheck) {
            return Center(
              child: Image.asset('images/PurpleBook.gif'),
            );
          }
          else{
            if (snapshot.hasData) {
              User? user = FirebaseAuth.instance.currentUser;
              String? userId = user?.uid;

              return StreamBuilder(
                stream: FirebaseDatabase.instance.ref().child('users').child(userId!).onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                    dynamic userData = snapshot.data!.snapshot.value;
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('images/PurpleBook.gif'),
                          ],
                        )
                    );
                  }
                },
              );
            } else {
              return LoginPage();
            }
          }
        },
      ),
    );
  }
}