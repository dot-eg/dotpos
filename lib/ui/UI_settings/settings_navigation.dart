import 'package:flutter/material.dart';
import 'about_spage.dart';
import 'users_spage.dart';
import 'history_spage.dart';
import 'analytics_spage.dart';
import '../text_styles.dart';


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
        page = Users();
        break;
      case 1:
        page = History();
        break;
      case 2:
        page = AnalyticsPage();
        break;
      case 3:
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
        SafeArea(
            child: NavigationRail(
              backgroundColor: Colors.black.withOpacity(0.5),
              extended: true,
              selectedLabelTextStyle: TextStyle(color: Colors.black),
              selectedIconTheme: IconThemeData(color: Colors.black),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.person, color: Colors.white,),
                  label: Text('Users', style: settingsNavTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history, color: Colors.white,),
                  label: Text('History', style: settingsNavTextStyle,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined, color: Colors.white,),
                  label: Text('Analytics', style: settingsNavTextStyle,),
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
          Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6640625,
                height: MediaQuery.of(context).size.height,
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