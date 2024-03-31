import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;

  List<Widget> _subpages = [
    General(),
    Users(),
    Security(),
    Personalization(),
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Row(
        children: [
          SettingsNavigationBar(
            selectedIndex: _selectedIndex,
            onIndexChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: _subpages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class SettingsNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  SettingsNavigationBar({required this.selectedIndex, required this.onIndexChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: ListView(
        children: [
          ListTile(
            title: Text('General'),
            selected: selectedIndex == 0,
            onTap: () => onIndexChanged(0),
          ),
          ListTile(
            title: Text('Users & Accounts'),
            selected: selectedIndex == 1,
            onTap: () => onIndexChanged(1),
          ),
          ListTile(
            title: Text('Security'),
            selected: selectedIndex == 2,
            onTap: () => onIndexChanged(2),
          ),
          ListTile(
            title: Text('Personalization'),
            selected: selectedIndex == 3,
            onTap: () => onIndexChanged(3),
          ),
          ListTile(
            title: Text('About'),
            selected: selectedIndex == 4,
            onTap: () => onIndexChanged(4),
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
        child: Text('General 1'),
      ),
    );
  }
}

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Users 2'),
      ),
    );
  }
}

class Security extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Security 3'),
      ),
    );
  }
}

class Personalization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Personalization 4'),
      ),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('About 5'),
      ),
    );
  }
}