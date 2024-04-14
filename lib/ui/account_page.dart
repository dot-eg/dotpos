import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
  
}

class _AccountPageState extends State<AccountPage> {
  final AuthService _authService = AuthService();

  void _onLogout() {
    setState(() {
      isLoggedIn = false;
    });
    _authService.signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Account Details'),
            Text('Current user: $currentUser'),
            Text('Last login: $loginTime'),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: _onLogout,
              child: Text('Logout'),
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: _onLogout,
              child: Text('Help'),
            ),
          ],
        ),
      ),
    );
  }
}