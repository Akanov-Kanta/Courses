import 'package:courses/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:courses/side_barDesktop.dart';

void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Courses NIS PTR",
      home: SideMenu()
    // Login()
  ));
}

