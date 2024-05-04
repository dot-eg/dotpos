import 'package:dotpos/ui/text_styles.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late List<bool> selected;
  late Future<List<User>> usersFuture;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    usersFuture = getUsersFromFirestore();
    usersFuture.then((value) {
      selected = List<bool>.filled(value.length, false);
    });
  }

  List<User> getSelectedUsers(List<User> users, List<bool> selected) {
    List<User> selectedUsers = [];
    for (int i = 0; i < users.length; i++) {
      if (selected[i]) {
        selectedUsers.add(users[i]);
      }
    }
    return selectedUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: AppBar(
            title: Text('Users', style: settingsHeader),
          ),
        ),
        FutureBuilder<List<User>>(
          future: usersFuture,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 0,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('User ID'),
                        ),
                        DataColumn(
                          label: Text('Email'),
                        ),
                        // Add more columns as needed
                      ],
                      rows:
                          snapshot.data!.asMap().entries.map<DataRow>((entry) {
                        int index = entry.key;
                        User user = entry.value;
                        return DataRow(
                          selected: selected[index],
                          cells: <DataCell>[
                            DataCell(Text(user.uid)),
                            DataCell(Text(user.email)),
                            // Add more cells as needed
                          ],
                          onSelectChanged: (bool? value) {
                            if (value != null) {
                              selected[index] = value;
                              setState(() {});
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 455,
                    child: SizedBox(
                      width: 125,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String displayname = '';
                              String username = '';
                              String password = '';
                              return Dialog(
                                  child: SizedBox(
                                width: 500,
                                height: 400,
                                child: AlertDialog(
                                  title: Text('Add User'),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Display Name'),
                                          onChanged: (value) {
                                            displayname = value;
                                          },
                                        ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Email'),
                                        onChanged: (value) {
                                          username = value;
                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Password'),
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
                                        String result =
                                            await authService.AddUser(displayname,
                                          username,
                                          password,
                                          context,
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            if (result == 'User Added') {
                                              return AlertDialog(
                                                title: Text('Success'),
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                                content: Text(result),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.black),
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
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ));
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: Text('Add User',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 455,
                    top: 120,
                    child: SizedBox(
                      width: 125,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          //List<User> selectedUsers = getSelectedUsers(snapshot.data!, selected);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete User'),
                                content: Text(
                                    'Are you sure you want to delete the selected user(s)?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      AlertDialog(
                                        title: Text('error'),
                                        content: Text(
                                            'You cannot delete the current user.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Delete User',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 455,
                    top: 170,
                    child: SizedBox(
                      width: 125,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          List<User> selectedUsers =
                              getSelectedUsers(snapshot.data!, selected);
                          if (selectedUsers.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('No user selected.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }
                          for (User user in selectedUsers) {
                            String result =
                                await authService.resetPassword(user.email);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                if (result == 'Password reset email sent') {
                                  return AlertDialog(
                                    title: Text('Success'),
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
                                          style: TextStyle(color: Colors.black),
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Text('Reset User',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.4,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                ],
              );
            }
          },
        )
      ],
    );
  }
}
