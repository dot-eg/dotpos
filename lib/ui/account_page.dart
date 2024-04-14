import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../ui/text_styles.dart';

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
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Stack(
        children:[ 
          Positioned(
            top: 20,
            left: 20,
            child: SizedBox(
              width: 700,
              height: 50,
              child: Text('Hello!, $currentUser', style: settingsHeader,),
            ),
            ),
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('My Account Details'),
            Text('Current user: $currentUser'),
            Text('Last login: $loginTime'),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: _onLogout,
              child: Text('Logout'),
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {},
              child: Text('Help'),
            ),
          ],
        )
        ],
    )
    );
  }
}