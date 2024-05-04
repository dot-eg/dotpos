
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/account_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.00630676,
              left: MediaQuery.of(context).size.width * 0.00976562,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.21809896,
                height: MediaQuery.of(context).size.height * 0.03784057,
                child: Text(
                  'Hello $displayname!',
                  style: settingsHeader.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.035,
              left: MediaQuery.of(context).size.width * 0.00976562,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.21809896,
                height: MediaQuery.of(context).size.height * 0.03784057,
                child: Text(
                  'Last Login: $loginTime',
                  style: settingsHeader.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5,
              left: MediaQuery.of(context).size.width * 0.03205128,
              child: Column(
                children: [
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16025641,
                    height: MediaQuery.of(context).size.height * 0.05976096,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Help', style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.01068376),)
                    ),
                  ),
                   Padding(padding: EdgeInsets.all(8)),
                 
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16025641,
                    height: MediaQuery.of(context).size.height * 0.05976096,
                    child: ElevatedButton(
                      onPressed: widget.onSettingsPressed,
                      child: Text('Settings', style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.01068376),)
                    ),
                  ),
                 
                  Padding(padding: EdgeInsets.all(8)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16025641,
                    height: MediaQuery.of(context).size.height * 0.05976096,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Notifications',style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.01068376))
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16025641,
                    height: MediaQuery.of(context).size.height * 0.05976096,
                    child: ElevatedButton(
                      onPressed: _onLogout,
                      child: Text('Logout', style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.01068376),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
