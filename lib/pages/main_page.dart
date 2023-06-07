import 'package:courses/const/constants.dart';
import 'package:courses/pages/courses/all_topics.dart';
import 'package:flutter/material.dart';
import 'package:courses/side_bar.dart';

import '../bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [Container()];
  late Widget currentPage;
  void changeCurrentPage(int index) {
    print(index);
    setState(() {
      currentPage = pages[index];
    });
  }

  void setCurrentPage(Widget page){
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    pages.add(Topics(setPage: setCurrentPage, changePage: changeCurrentPage,));
    currentPage = pages[0];
    // TODO: implement initState
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print(currentPage.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.table_rows_sharp, color: DarkPurple),
        ),
        title: Row(
          children: [
            SizedBox(
              height: AppBar().preferredSize.height / 1.5,
              child: Image.asset(
                'assets/images/nisCourses.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            VerticalDivider(),
            Text('data')
          ],
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Sidebar(),
      body: currentPage,
      bottomNavigationBar: BottomBar(
        changePage: changeCurrentPage,
      ),
    );
  }
}
