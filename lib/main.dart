import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 runApp(MyApp());
 await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedIndex = 0;

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
          bottomNavigationBar: selectedIndex == 4 ? null : BottomNavigationBar(
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
        );
      }
    );
  }
}

class LoginScreenPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
    width: 1528,
    height: 1000,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: 968,
                top: 105,
                child: SizedBox(
                    width: 290,
                    height: 78,
                    child: Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w500,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 894,
                    height: 1000,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                            fit: BoxFit.fill,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 48,
                top: 44,
                child: SizedBox(
                    width: 131,
                    height: 74,
                    child: Text(
                        'dot.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 70,
                            fontFamily: 'Kollektif',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: -5,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 968,
                top: 193,
                child: SizedBox(
                    width: 486,
                    height: 190,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 24,
                                child: Container(
                                    width: 486,
                                    height: 56,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide.strokeAlignOutside,
                                                color: Color(0xFFC3BBBB),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                        ),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Username',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your username';
                                        }
                                        return null;
                                      },
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 0,
                                top: 134,
                                child: Container(
                                    width: 486,
                                    height: 56,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide.strokeAlignOutside,
                                                color: Color(0xFFC4BBBB),
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                        ),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 4,
                                top: 0,
                                child: SizedBox(
                                    width: 162,
                                    height: 24,
                                    child: Text(
                                        'Username',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Hind Kochi',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 4,
                                top: 105,
                                child: SizedBox(
                                    width: 162,
                                    height: 24,
                                    child: Text(
                                        'Password',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Hind Kochi',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 968,
                top: 414,
                child: Container(
                    width: 486,
                    height: 65,
                    decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: [
                            BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                                spreadRadius: 1,
                            )
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 1125,
                top: 437,
                child: SizedBox(
                    width: 150,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () async {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => ProductHomePage(),
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child:Text(
                        'Log in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w500,
                            height: 0,
                        ),
                      ),
                    ),
                ),
            ),
            Positioned(
                left: 1004,
                top: 500,
                child: SizedBox(
                    width: 413,
                    height: 23,
                    child: Text(
                        'Looking for the admin console? click here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w500,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 989,
                top: 700,
                child: SizedBox(
                    width: 465,
                    height: 54,
                    child: Text(
                        '© 2024 dot. , Made in the New Administrative Capital with ♡',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w500,
                            height: 0,
                        ),
                    ),
                ),
            ),
        ],
    ),
)
    );
  }
}

class ProductHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
    width: 1366,
    height: 1024,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: 936,
                top: 0,
                child: Container(
                    width: 430,
                    height: 932,
                    decoration: BoxDecoration(color: Color(0xFFA5A5A5)),
                ),
            ),
            Positioned(
                left: 936,
                top: 0,
                child: Container(
                    width: 430,
                    height: 81,
                    decoration: BoxDecoration(color: Colors.black),
                ),
            ),
            Positioned(
                left: 61,
                top: 71,
                child: SizedBox(
                    width: 802,
                    height: 826,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 163,
                                top: 0,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 652,
                                top: 0,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 326,
                                top: 0,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 489,
                                top: 0,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 0,
                                top: 169,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 163,
                                top: 169,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 652,
                                top: 169,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 326,
                                top: 169,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 489,
                                top: 169,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 0,
                                top: 507,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 163,
                                top: 507,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 652,
                                top: 507,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 326,
                                top: 507,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 489,
                                top: 507,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 0,
                                top: 676,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 163,
                                top: 676,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 652,
                                top: 676,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 326,
                                top: 676,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 489,
                                top: 676,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 0,
                                top: 338,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 163,
                                top: 338,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 652,
                                top: 338,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 326,
                                top: 338,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                            Positioned(
                                left: 489,
                                top: 338,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 53,
                top: 19,
                child: SizedBox(
                    width: 195,
                    height: 42,
                    child: Text(
                        'Products',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'Content',
                            fontWeight: FontWeight.w700,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 974,
                top: 840,
                child: SizedBox(
                    width: 353,
                    height: 57,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                    width: 353,
                                    height: 57,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 37.50,
                                                top: 12,
                                                child: SizedBox(
                                                    width: 277,
                                                    height: 33,
                                                    child: Text(
                                                        'Payment',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontFamily: 'Content',
                                                            fontWeight: FontWeight.w700,
                                                            height: 0,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 1053,
                top: 19,
                child: SizedBox(
                    width: 195,
                    height: 42,
                    child: Text(
                        'Cart',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Content',
                            fontWeight: FontWeight.w700,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 931.51,
                child: SizedBox(
                    width: 1366,
                    height: 92.49,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 1366,
                                    height: 92.49,
                                    decoration: BoxDecoration(color: Colors.black),
                                ),
                            ),
                            Positioned(
                                left: 103.52,
                                top: 23.98,
                                child: Container(
                                    width: 42.69,
                                    height: 45.67,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 39.49,
                                top: 23.98,
                                child: Container(
                                    width: 42.69,
                                    height: 45.67,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(),
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 167.55,
                                top: 23.98,
                                child: Container(
                                    width: 42.69,
                                    height: 45.67,
                                    decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: OvalBorder(),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ],
    ),
)
    );
  }
}


class HistoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No history yet'),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('You have ' 
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          )
      ],
    );
  }
}