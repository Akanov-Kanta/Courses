import 'package:courses/pages/LoginPage.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:courses/pages/courses/entry_page.dart';
import 'package:courses/pages/courses/topic_courses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Courses NIS PTR",
      home: Topics(),
    // Login()
  ));
}

