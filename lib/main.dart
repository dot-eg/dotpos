import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'product_home_page.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'dot.',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 146, 159, 168)),
        ),
        home: LoginScreenPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
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
        signOut();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
}
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          ),
          bottomNavigationBar: Visibility(
            visible: page is! LoginScreenPage,
            child: BottomNavigationBar(
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
            fixedColor: Colors.black,
            unselectedItemColor: Colors.black,
            onTap:(value) {
              setState(() {
                selectedIndex = value;
            });
          },     
        ),
        )
        );
      }
    );
  }
}

class HistoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Center(
        child: Text('No history yet'),
      );
  }
}

