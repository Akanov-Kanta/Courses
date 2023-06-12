import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key, required this.changePage});
  void Function(int) changePage;
  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        selectedItemColor: Color.fromRGBO(2, 56, 209, 1),
        unselectedItemColor: Color.fromRGBO(106, 106, 139, 1),
        iconSize: 40,
        onTap: (int index){
          setState((){
            selectedIndex = index;
          });
          widget.changePage(index);
        },
        elevation: 5,
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Расписание',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Курсы',
          ),
        ],
      );
  }
}