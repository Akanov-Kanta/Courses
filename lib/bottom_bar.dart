import 'package:courses/const/constants.dart';
import 'package:courses/main.dart';
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
        selectedItemColor: DarkPurple,
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
            icon: Icon(userRole == Roles.student ? Icons.list_rounded : userRole == Roles.teacher ? Icons.work_rounded : Icons.people_rounded),
            label: userRole == Roles.student ? 'Расписание' : userRole == Roles.teacher ? 'Мои курсы' : 'Пользователи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Курсы',
          ),
        ],
      );
  }
}