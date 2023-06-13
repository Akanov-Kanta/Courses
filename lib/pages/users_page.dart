import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(25),
      children: [
        UserTile(
            name: 'Ғалымжан Арсен Ренатұлы',
            email: 'galymjan_a1101@ptr.nis.edu.kz',
            role: 'Ученик 9D')
      ],
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
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Futura',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                          width: double.infinity,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          )),
                    ),
                  ],
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
