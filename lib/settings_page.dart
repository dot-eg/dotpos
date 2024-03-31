import 'package:flutter/material.dart';

TextStyle settingsPageTextStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w200,
  color: Colors.white,
  fontFamily: 'Hind Kochi'
);

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = General();
        break;
      case 1:
        page = Users();
        break;
      case 2:
        page = Security();
        break;
      case 3:
        page = Personalization();
        break;
      case 4:
        page = About();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              backgroundColor: Colors.black.withOpacity(0.5),
              extended: true,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.settings, color: Colors.white,),
                  label: Text('General', style: settingsPageTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person, color: Colors.white,),
                  label: Text('Users', style: settingsPageTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.lock, color: Colors.white,),
                  label: Text('Secuity', style: settingsPageTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.color_lens, color: Colors.white,),
                  label: Text('Personalization', style: settingsPageTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info, color: Colors.white,),
                  label: Text('About', style: settingsPageTextStyle,),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
              child: Container(
                width: 1020,
                height: 900,
                color: Colors.white,
                child: page,
            ),
          ),
        ],
      ),
    );
  }
}

class General extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('General 1', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Users 2', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class Security extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Security 3', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class Personalization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Personalization 4', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('About 5', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}