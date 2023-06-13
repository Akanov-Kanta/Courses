import 'package:courses/const/constants.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:courses/pages/courses/teacherCourses.dart';
import 'package:courses/pages/courses/topic_courses.dart';
import 'package:courses/pages/schedule.dart';
import 'package:courses/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:courses/side_bar.dart';

import '../bottom_bar.dart';
import '../main.dart';
import 'courses/createnewcourse.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [
    userRole == Roles.student
        ? Schedule()
        : userRole == Roles.teacher
            ? teacherCoursesList()
            : UsersListPage()
  ];
  late Widget currentPage;
  void changeCurrentPage(int index) {
    setState(() {
      currentPage = pages[index];
    });
  }

  void setCurrentPage(Widget page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    pages.add(Topics(
      setPage: setCurrentPage,
      changePage: changeCurrentPage,
    ));
    currentPage = pages[0];
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.table_rows_rounded, color: DarkPurple),
        ),
        centerTitle: true,
        title: SizedBox(
          height: AppBar().preferredSize.height / 1.5,
          child: Image.asset(
            'assets/images/nisCourses.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Sidebar(),
      floatingActionButton: userRole == Roles.admin
          ? (currentPage.runtimeType == Topics
              ? FloatingActionButton(
                  onPressed: () {
                    print("ADMIN TOPICS");
                  },
                  child: Icon(Icons.create_new_folder_rounded),
                  backgroundColor: DarkPurple,
                )
              : currentPage.runtimeType == TopicCourses
                  ? FloatingActionButton(
                      onPressed: () {
                        print("ADMIN COURSES");
                        showDialog(context: context, builder: (context){
                          return CreateNewCourse();
                        });
                      },
                      child: Icon(Icons.my_library_add_rounded),
                      backgroundColor: DarkPurple,
                    )
                  : currentPage.runtimeType == UsersListPage
                  ? FloatingActionButton(
                      onPressed: () {
                        print("ADMIN PEOPLE");
                      },
                      child: Icon(Icons.group_add_rounded),
                      backgroundColor: DarkPurple,
                    ) : null)
          : null,
      body: currentPage,
      bottomNavigationBar: BottomBar(
        changePage: changeCurrentPage,
      ),
    );
  }
}
