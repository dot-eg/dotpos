import 'package:flutter/material.dart';

TextStyle settingsNavTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: Colors.white,
  fontFamily: 'Hind Kochi'
);

TextStyle settingsHeader = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontFamily: 'Hind Kochi'
);

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {
  var selectedIndex = 0;
  bool isHovered = false;

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://images.unsplash.com/photo-1554034483-04fda0d3507b?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            fit: BoxFit.fill,
          ),
        ),
      child: Row(
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
          child: SafeArea(
            child: NavigationRail(
              backgroundColor: Colors.black.withOpacity(0.5),
              extended: isHovered,
              selectedLabelTextStyle: TextStyle(color: Colors.black),
              selectedIconTheme: IconThemeData(color: Colors.black),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.settings, color: Colors.white,),
                  label: Text('General', style: settingsNavTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person, color: Colors.white,),
                  label: Text('Users', style: settingsNavTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.lock, color: Colors.white,),
                  label: Text('Secuity', style: settingsNavTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.color_lens, color: Colors.white,),
                  label: Text('Personalization', style: settingsNavTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info, color: Colors.white,),
                  label: Text('About', style: settingsNavTextStyle,),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            )
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
      )
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
    return Row(
      children: [
        Expanded(
          child: AppBar(
              title: Text('About', style: settingsHeader),
            ),
          ),
        ],
      );
}
}