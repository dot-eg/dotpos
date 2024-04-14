import 'package:dotpos/ui/account_page.dart';
import 'package:dotpos/ui/inventory_page.dart';
import 'package:flutter/material.dart';
import '../ui/transaction_history.dart';
import '../ui/product_home_page.dart';
import '../ui/UI_settings/settings_navigation.dart';
import '../services/auth_service.dart';

class CurrentPage extends StatefulWidget {
  @override
  State<CurrentPage> createState() => NavigationBar();
}

class NavigationBar extends State<CurrentPage> {
  var selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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
        page = InventoryPage();
        break;
      case 3:
        page = SettingsPage();
        break;
      case 4:
        page = AccountPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
}
  return Scaffold(
      body: page,
      bottomNavigationBar: isLoggedIn ? BottomNavigationBar(
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
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 122, 125, 128).withOpacity(0.5),
      ) : null,
    );
  }
}
