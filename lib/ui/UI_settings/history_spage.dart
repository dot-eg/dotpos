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
          top: 70, // Set the top position to the desired value
          left: 20, // Set the left position to the desired value
          child: SizedBox(
            height: 30,
            width: 250,
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
              child: Text('Clear All Transaction History', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}