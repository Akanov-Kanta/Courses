import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SidebarD extends StatefulWidget{
  const SidebarD({super.key});

  @override
  State<SidebarD> createState()=> _SidebarDState();
}

class _SidebarDState extends State<SidebarD>{
  @override
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(2, 56, 209, 1),
        unselectedItemColor: Color.fromRGBO(106, 106, 139, 1),
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Chats',
          ),
        ],
      ),
      body: SafeArea(
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
          width: 288,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(9, 116, 7, 0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(25, 17, 121, 0.1), // Задаем серый цвет фона
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(56), // Округляем правый верхний угол// Округляем правый нижний угол
                      ),

                    ),

                    padding: EdgeInsets.only(top:4,bottom: 13),

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
              Padding(
                padding: EdgeInsets.only(left:10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Расписание',
                        style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),

                      ),
                      onTap: (){
                        print("Расписание");
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Курсы',
                        style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),
                      ),
                      onTap: (){
                        print("Курсы");
                      },
                    ),
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Courses", style: TextStyle(fontFamily: "poppins", fontSize: 18,fontWeight: FontWeight.w600, color: Color(0xFF2E2E5D)),),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Курс 1:  Робототехника',
                        style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),
                      ),
                      onTap: (){
                        print("Курс 1");
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Курс 2:  Вокал',
                        style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5, fontFamily: "poppins"),
                      ),
                      onTap: (){
                        print("Курс 2");
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Секция:  Баскетбол',
                        style: TextStyle(color: Color(0xFF2E2E5D), letterSpacing: .5,fontFamily: "poppins"),

                      ),
                      onTap: (){
                        print("Секция");
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}