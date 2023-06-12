import 'package:flutter/material.dart';
import 'package:courses/side_bar.dart';
import 'package:courses/side_barDesktop.dart';

class SplitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 1200.0;
    if (screenWidth >= breakpoint) {
      print("omg");
      // widescreen: menu on the left, content on the right
      return SidebarD();
    } else {
      // narrow screen: show content, menu inside drawer
      return Sidebar();
    }
  }
}