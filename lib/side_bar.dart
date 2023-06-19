import 'package:courses/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'const/constants.dart';
import 'main.dart';

class Sidebar extends StatefulWidget {
  Sidebar({super.key, required this.changePage});
  void Function(int) changePage;
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    bool isD = isDesktop(context);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color:
                    Color.fromRGBO(25, 17, 121, 0.1), // Задаем серый цвет фона
                borderRadius: BorderRadius.only(
                  bottomRight:
                      Radius.circular(56), // Округляем правый нижний угол
                ),
              ),
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 9,
                  bottom: 9,
                  right: 9,
                  left: 9),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF4838D1),
                        size: 40,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    tileColor: Colors.black,
                  ),
                  ListTile(
                    tileColor: Colors.black,
                    title: Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(
                          color: Color(0xFF2E2E5D),
                          letterSpacing: .5,
                          fontFamily: "poppins"),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 40,
            child: Image.asset("assets/images/nisCourses.png"),
          ),
          if(isD) ListTile(
            title: Text(
              userRole == Roles.student
                  ? 'Расписание'
                  : userRole == Roles.teacher
                      ? 'Мои курсы'
                      : 'Пользователи',
              style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
            ),
            leading: Icon(userRole == Roles.student ? Icons.list_rounded : userRole == Roles.teacher ? Icons.work_rounded : Icons.people_rounded, color: DarkPurple,),
            onTap: () {
              widget.changePage(0);
            },
          ),
          if(isD) ListTile(
            title: Text(
              'Курсы',
              style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
            ),
            leading: Icon(Icons.my_library_books, color: DarkPurple,),
            onTap: () {
              widget.changePage(1);
            },
          ),
          if(isD) SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[700],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Курс 1:  Робототехника',
              style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Курс 2:  Вокал',
              style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Секция:  Баскетбол',
              style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
            ),
            onTap: () {},
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[700],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Выход',
              style: TextStyle(letterSpacing: .5, fontFamily: "poppins"),
            ),
            leading: Icon(Icons.logout_rounded),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
