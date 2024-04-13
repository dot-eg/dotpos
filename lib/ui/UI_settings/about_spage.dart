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
            top: MediaQuery.of(context).size.height * 0.12613522,
            left: MediaQuery.of(context).size.width * 0.48828125,
            child: Container(
                    width: MediaQuery.of(context).size.width * 0.32552083,
                    height: MediaQuery.of(context).size.height * 0.63067608,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/LogoWBG.png'),
                        ),
                    ),
                ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.01171875,
            top: MediaQuery.of(context).size.height * 0.06306761,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35807292,
                height: MediaQuery.of(context).size.height * 0.07568113,
                child: Text(
                    '© 2024 dot. , Made in the New Administrative Capital with ♡',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.01302083,
                        fontFamily: 'Hind Kochi',
                        fontWeight: FontWeight.w500,
                        height: 0,
                    ),
                ),
            ),
        ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.01171875,
            top: MediaQuery.of(context).size.height * 0.1450555,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35807292,
                height: MediaQuery.of(context).size.height * 0.25227043,
                child: Text("dot. is a Point-of-Sale application developed using Flutter/Dart and Firebase Cloud Firestore as a data structure. This project applied the use of critical software engineering theories such as agile methodologies for development with focusing on implementing an architectural model, design patterns and pre-release testing strategies.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.01302083,
                        fontFamily: 'Hind Kochi',
                        fontWeight: FontWeight.w500,
                        height: 0,
                    ),
                ),
            ),
        ),
        Positioned(
            left: MediaQuery.of(context).size.width * 0.01171875,
            top: MediaQuery.of(context).size.height * 0.41624622,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35807292,
                height: MediaQuery.of(context).size.height * 0.07568113,
                child: Text('Integrative Project, TKH - Coventry University Egypt, Computer Science Level 4 - S02',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.01302083,
                        fontFamily: 'Hind Kochi',
                        fontWeight: FontWeight.w500,
                        height: 0,
                    ),
                  ),
            ),
        ),
        Positioned(
            left: MediaQuery.of(context).size.width * 0.01171875,
            top: MediaQuery.of(context).size.height * 0.50454087,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35807292,
              height: MediaQuery.of(context).size.height * 0.31545741,
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