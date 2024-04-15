
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../ui/text_styles.dart';

class AccountPage extends StatefulWidget {
  final VoidCallback? onSettingsPressed;

  AccountPage({this.onSettingsPressed});

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
        title: Text('Account', style: TextStyle(fontSize: 30)),
      ),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.00630676,
            left: MediaQuery.of(context).size.width * 0.00976562,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.21809896,
              height: MediaQuery.of(context).size.height * 0.03784057,
              child: Text(
                'Hello!, $currentUser',
                style: settingsHeader.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),

          //   Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text('My Account Details'),
          //     Text('Current user: $currentUser'),
          //     Text('Last login: $loginTime'),

          Positioned(
            top: 400,
            left: 40,
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onLogout,
                    child: Text('Logout'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Help'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Notifications'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: widget.onSettingsPressed,
                    child: Text('Settings'),
                  ),
                ),
              ],
            ),
          ),
          //     Padding(padding: EdgeInsets.all(10)),
          //     ElevatedButton(
          //       onPressed: () {},
          //       child: Text('Help'),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
