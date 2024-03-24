import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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

// ...

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
        page = Placeholder();
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
          bottomNavigationBar: BottomNavigationBar(
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
                child: Container(
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
                child: Container(
                    width: 353,
                    height: 57,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
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
                child: Container(
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
    )
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asUpperCase, style: style),
      ),
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