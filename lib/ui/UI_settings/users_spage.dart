import 'package:dotpos/ui/text_styles.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class Users extends StatelessWidget {
  final Future<List<User>> usersFuture = getUsersFromFirestore();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: AppBar(
            title: Text('Users', style: settingsHeader),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          child: FutureBuilder<List<User>>(
            future: usersFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('User ID'),
                    ),
                    DataColumn(
                      label: Text('Email'),
                    ),
                    // Add more columns as needed
                  ],
                  rows: snapshot.data!.map<DataRow>((User user) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(user.uid)),
                        DataCell(Text(user.email)),
                        // Add more cells as needed
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        Positioned(
            top: 70,
            left: 500,
            child: SizedBox(
              width: 125,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String username = '';
                      String password = '';
                      return AlertDialog(
                        title: Text('Add User'),
                        content: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Username'),
                              onChanged: (value) {
                                username = value;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Add'),
                            onPressed: () async {
                              String result = await authService.AddUser(
                                  username, password, context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    if (result == 'User Added') {
                                      return AlertDialog(
                                        title: Text('Sucess'),
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                        content: Text(result),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        icon: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        content: Text(result),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'OK',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Add User', style: TextStyle(color: Colors.black)),
              ),
            )),
        Positioned(
          left: 500,
          top: 120,
          child: SizedBox(
            width: 125,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Delete User', style: TextStyle(color: Colors.red)),
                  ),
          )
        ),
        Positioned(
          left: 500,
          top: 170,
          child: SizedBox(
            width: 125,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Reset User', style: TextStyle(color: Colors.black)),
                  ),
          )
        ),
      ],
    );
  }
}
