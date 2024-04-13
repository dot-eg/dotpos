import 'package:flutter/material.dart';
import '../text_styles.dart';
import '../../services/trans_service.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: AppBar(
              title: Text('History', style: settingsHeader),
            ),
          ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08829465, // Set the top position to the desired value
          left: MediaQuery.of(context).size.width * 0.01302083, // Set the left position to the desired value
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.03784057, // Set the height to the desired value
            width: MediaQuery.of(context).size.width * 0.16276042, // Set the width to the desired value
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Warning'), icon: Icon(Icons.warning_amber, color: Colors.red, size: 30,),
                            content: Text('This Action Cannot Be Undone. Are You Sure You Want To Clear All Transaction History?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  clearAllTransactions();
                                  Navigator.of(context).pop();
                                },
                                child: Text('I\'m Sure', style: TextStyle(color: Colors.red),),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel', style: TextStyle(color: Colors.black),),
                              ),
                            ],
                          );
                        },
                      );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              ),
              child: Text('Clear All Transaction History', 
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.00976562, fontFamily: 'Hind Kochi', fontWeight: FontWeight.w500, height: 0,)
                          ),
            ),
          ),
        ),
      ],
    );
  }
}