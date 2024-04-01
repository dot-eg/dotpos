import 'package:flutter/material.dart';
import 'about_spage.dart';
import 'general_spage.dart';
import 'users_spage.dart';
import 'security_spage.dart';
import 'personalization_spage.dart';
import 'package:dotpos_1/ui/text_styles.dart';


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
            image: AssetImage('assets/images/backgrounds/products_bg.jpg'),
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