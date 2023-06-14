import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.reference().child("users").onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
          return const Center(
            child: Text("Нет резюме"),
          );
        }

        final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
        final users = data.entries.map((entry) => User.fromMap(entry.value)).toList();

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            return UserTile(
                name: user.fio,
                email: user.email,
                role: user.role,
            );
          },
        );
      },
    );
  }
}

class User {
  final String fio;
  final String grade;
  final String role;
  final String email;

  User({
    required this.fio,
    required this.grade,
    required this.role,
    required this.email,
  });

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      fio: map['fio'] ?? '',
      grade: map['grade'] ?? '',
      role: map['role'] ?? '',
      email: map['email'] ?? '',
    );
  }
}

class UserTile extends StatelessWidget {
  UserTile(
      {super.key, required this.name, required this.email, required this.role});
  final String name, email, role;
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
                border: Border.all(color: Colors.grey, width: 0.5)),
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
                          onPressed: () {},
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
