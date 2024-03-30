import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'main.dart';
import 'product_home_page.dart';
import 'login_screen.dart';

class CurrentPage extends StatefulWidget {
  @override
  State<CurrentPage> createState() => NavigationBar();
}

class NavigationBar extends State<CurrentPage> {
  final AuthService _authService = AuthService();
  var selectedIndex = 0;
  bool _isLoggedIn = true;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      _isLoggedIn = index != 4;
    });
  }
  
  @override
  Widget build(BuildContext context) { 
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ProductHomePage();
        break;
      case 1:
        page = HistoryPage();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      case 4:
        page = LoginScreenPage();
        _authService.signOut();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
}
  return Scaffold(
      body: page,
      bottomNavigationBar: _isLoggedIn ? BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history), 
                label: "Transactions History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory),
                label: 'Inventory',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Log Out',
              ),
            ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue.withOpacity(0.5),
      ) : null,
    );
  }
}
