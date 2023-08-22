import 'package:courses/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../create_excel.dart';
import '../utils.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final TextEditingController searchController = TextEditingController();
  String searchResult = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Поиск пользователя',
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                            width: 0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          searchResult = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () async {
                        var event = await FirebaseDatabase.instance
                            .ref()
                            .child('users')
                            .once();
                        makeExcelUsersDoc(event.snapshot.value as Map);
                      },
                      icon: Icon(Icons.file_download_rounded))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref().child('users').onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Image.asset('images/PurpleBook.gif'),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Ошибка получения данных"),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data?.snapshot?.value == null) {
                  return Center(
                    child: Text("Нет данных"),
                  );
                }
                final List<User> users = [];

                final dynamic snapshotValue = snapshot.data!.snapshot!.value!;
                if (snapshotValue is Map<dynamic, dynamic>) {
                  final data = snapshotValue as Map<dynamic, dynamic>;
                  data.forEach((key, value) {
                    if (value is Map<dynamic, dynamic>) {
                      users.add(User.fromMap(key, value));
                    } else {
                      print(
                          "Неправильный тип данных для пользователя с ключом '$key': ${value.runtimeType}");
                    }
                  });
                } else {
                  print(
                      "Неправильный тип данных: ${snapshotValue.runtimeType}");
                  return Center(
                    child: Text("Нет данных"),
                  );
                }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(10.0),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    if (user.fio
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()) ||
                        user.email
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()) ||
                        user.grade
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                      return UserTile(
                        onDelete: () => _deleteUser(user,context),
                        name: user.fio,
                        email: user.email,
                        role: user.role,
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _deleteUser(User user, BuildContext context) async {
    Map userData = (await FirebaseDatabase.instance
            .ref()
            .child("users")
            .child(user.id)
            .get())
        .value as Map;
    
    if (userData['role'] == 'Student') {//deleting student from courses
      List<String> studentCourses =
          (userData['courses'] as Map).values.toList().cast();
      final dref = FirebaseDatabase.instance.ref();
      studentCourses.forEach((element) {
        dref
            .child('courses')
            .child(element)
            .child('students')
            .child(user.id)
            .remove()
            .then((value) => print('deleted ${user.id} from $element'));
      });
    }else if(userData['role'] == 'Teacher' && userData['courses'] != null){
      //запрет удаления учителя с курсами 
      SnackBarService.showSnackBar(context, 'Учитель имеет курсы под руководством', true);
      return;
    }
    // Delete from Firebase Realtime Database
    FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(user.id)
        .remove()
        .then((_) {
      print("User deleted successfully from Realtime Database");
    }).catchError((error) {
      print("Failed to delete user from Realtime Database: $error");
    });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.email, // Email админского аккаунта
      password: user.password, // Пароль админского аккаунта
    );

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.uid == user.id) {
        Authcheck = true;

        // Delete the currently authenticated user
        await currentUser.delete();
        print("User deleted successfully from Firebase Authentication");
      }
    } catch (error) {
      print("Failed to delete user from Firebase Authentication: $error");
    }
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "test@gmail.com", // Email админского аккаунта
      password: "test123", // Пароль админского аккаунта
    );
    Authcheck = false;
  }
}

class User {
  final String id;
  final String fio;
  final String grade;
  final String role;
  final String email;
  final String password;

  User(
      {required this.id,
      required this.fio,
      required this.grade,
      required this.role,
      required this.email,
      required this.password});

  factory User.fromMap(String id, Map<dynamic, dynamic> data) {
    return User(
      password: data['password'] ?? '',
      id: id,
      fio: data['fio'] ?? '',
      grade: data['grade'] ?? '',
      role: data['role'] ?? '',
      email: data['email'] ?? '',
    );
  }
}

class UserTile extends StatelessWidget {
  UserTile({
    Key? key,
    required this.name,
    required this.email,
    required this.role,
    required this.onDelete,
  });

  final String name, email, role;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 242, 241, 247),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Futura',
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: onDelete,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          email,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          role,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
