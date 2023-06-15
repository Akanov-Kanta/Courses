import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child('users').onValue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Ошибка получения данных"),
          );
        }

        if (!snapshot.hasData || snapshot.data?.snapshot?.value == null) {
          return Center(
            child: Text("Нет данных"),
          );
        }

        final users = <User>[];
        final dynamic snapshotValue = snapshot.data!.snapshot!.value!;
        if (snapshotValue is Map<dynamic, dynamic>) {
          final data = snapshotValue as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              users.add(User.fromMap(key, value));
            } else {
              print("Неправильный тип данных для пользователя с ключом '$key': ${value.runtimeType}");
            }
          });
        } else {
          print("Неправильный тип данных: ${snapshotValue.runtimeType}");
          return Center(
            child: Text("Нет данных"),
          );
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            return UserTile(
              onDelete: () => _deleteUser(user),
              name: user.fio,
              email: user.email,
              role: user.role,
            );
          },
        );
      },
    );
  }

  void _deleteUser(User user) async {
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

    // Delete from Firebase Authentication
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.uid == user.id) {
        // Delete the currently authenticated user
        await currentUser.delete();
        print("User deleted successfully from Firebase Authentication");
      }
    } catch (error) {
      print("Failed to delete user from Firebase Authentication: $error");
    }
  }
}

class User {
  final String id;
  final String fio;
  final String grade;
  final String role;
  final String email;

  User({
    required this.id,
    required this.fio,
    required this.grade,
    required this.role,
    required this.email,
  });

  factory User.fromMap(String id, Map<dynamic, dynamic> data) {
    return User(
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
