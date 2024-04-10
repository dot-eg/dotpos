import 'package:flutter/material.dart';
import '../text_styles.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: AppBar(
              title: Text('About', style: settingsHeader),
            ),
          ),
          Positioned(
            top: 100,
            left: 900,
            child: Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/LogoWBG.png'),
                        ),
                    ),
                ),
          ),
          Positioned(
            left: 18,
            top: 50,
            child: SizedBox(
                width: 550,
                height: 60,
                child: Text(
                    '© 2024 dot. , Made in the New Administrative Capital with ♡',
                    textAlign: TextAlign.left,
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
            left: 18,
            top: 115,
            child: SizedBox(
                width: 550,
                height: 200,
                child: Text("dot. is a Point-of-Sale application developed using Flutter/Dart and Firebase Cloud Firestore as a data structure. This project applied the use of critical software engineering theories such as agile methodologies for development with focusing on implementing an architectural model, design patterns and pre-release testing strategies.",
                    textAlign: TextAlign.left,
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
            left: 18,
            top: 330,
            child: SizedBox(
                width: 550,
                height: 200,
                child: Text('Integrative Project, TKH - Coventry University Egypt, Computer Science Level 4 - S02',
                    textAlign: TextAlign.left,
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
            left: 18,
            top: 400,
            child: SizedBox(
              width: 550,
              height: 250,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Omar Elfiki', style: membersList,),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Ali Nasr', style: membersList),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Mohamad Assal', style: membersList 
                    ),  
                    ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Wasima Elshiekh', style: membersList 
                    ),  
                    ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Ahmed Nouier', style: membersList 
                    ),  
                    ),
                ],
              )
            ),
          ),      
        ],
      );
}
}