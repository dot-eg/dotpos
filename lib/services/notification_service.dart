import 'package:dotpos/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class NotificationService {
  Future<bool> getIsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifcationsEnabled') ?? false;
  }

  Future<String> getQuantityThreshold() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('quantity') ?? '0';
  }

  void showLowQuantityNotification(BuildContext con) async {
    bool enabled = await getIsEnabled();
    if (!enabled) {
      return;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: con,
          builder: (context) {
            // Change this line
            return AlertDialog(
              title: Text('Low Quantity Alert'),
              content: Text('You are running low on stock for $lowquantity'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
      );
    }
  }
}