import 'package:flutter/material.dart';


class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: [
                Container(
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 116, 7, 0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(25, 17, 121, 0.1), // Задаем серый цвет фона
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(56), // Округляем правый верхний угол// Округляем правый нижний угол
                              ),

                            ),

                            padding: EdgeInsets.all(9),

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
                      ),
                      Divider(
                        height: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
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
              ],
            ),

          ),
        ),
        body: Column(
          mainAxisAlignment : MainAxisAlignment.start,
          crossAxisAlignment : CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                onPressed: () { openDrawer(); },
                child: Icon(Icons.table_rows_sharp, color:Colors.blue),
                backgroundColor: Colors.white,

              ),
            )
          ],
        )
    );
  }
}
