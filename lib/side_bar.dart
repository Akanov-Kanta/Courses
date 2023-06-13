import 'package:flutter/material.dart';


class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(72, 56, 209, 0.2),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(2,2), // Adjust the shadow position as needed
                ),
              ],
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(25, 17, 121, 0.1), // Задаем серый цвет фона
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(56), // Округляем правый верхний угол// Округляем правый нижний угол
                      ),
                    ),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 9, bottom: 9, right: 9, left: 9),

                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person, color: Color(0xFF4838D1), size: 40,),
                            backgroundColor:Colors.white,
                          ),
                          tileColor: Colors.black,
                        ),
                        ListTile(
                          tileColor: Colors.black,
                          title:Text("bekkozhina_a0701@ptr.nis.edu.kz", style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),

                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 40,
                  child: Image.asset("assets/images/nisCourses.png"),
                ),
                ListTile(
                  title: Text(
                    'Курс 1:  Робототехника',
                    style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Курс 2:  Вокал',
                    style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Секция:  Баскетбол',
                    style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5,fontFamily: "poppins"),

                  ),
                )
              ],
            ),

          ),
        );
  }
}
