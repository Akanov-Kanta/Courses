import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatefulWidget{
  const SideMenu({super.key});

  @override
  State<SideMenu> createState()=> _SideMenuState();
}

class _SideMenuState extends State<SideMenu>{
  @override
  bool isSideBarOpen = false;
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
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
              width: 288,
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
            if (isSideBarOpen)
              GestureDetector(
                onTap: () {
                  // Handle the tap to close the side bar
                  setState(() {
                    isSideBarOpen = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.6), // Adjust the opacity as needed
                ),
              ),
              Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(left: isSideBarOpen ? 288 : 0),
                    child: Column(
                      children: [
                        Text("hello world")
                      ],
                    ),
                  )
              )
          ],
        ),

      ),
    );
  }
}