import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsService {
 final conn = db;
 String? currentdoc;
 final _currentdocController = StreamController<String>.broadcast();

 Stream<String> get currentdocStream => _currentdocController.stream;

 static final AnalyticsService _singleton = AnalyticsService._internal();

  factory AnalyticsService() {
    return _singleton;
  }
 
  AnalyticsService._internal();

Future<String> createSalesReport() async {
  try {
    DocumentReference docRef = await conn.collection('Sales Reporting').add({
      'Sales': 0,
      'Total Revenue': 0,
    });
    currentdoc = docRef.id;
    _currentdocController.add(currentdoc!);
    print("Current Sales Report ID: $currentdoc");
    return "Sales Report Created Successfully\nCurrent Sales Report ID: $currentdoc";
  } catch (e) {
    print(e.toString());
    return "Error Creating Sales Report";
  }
}

Future<void> updateManualSalesReport(int sales, double revenue) async {
  try {
    await conn.collection('Sales Reporting').doc(currentdoc).update({
      'Sales': sales,
      'Total Revenue': revenue,
    });
  } catch (e) {
    print(e.toString());
  }
}

Future<String> deleteSalesReport() async {
    if (currentdoc!.isEmpty) {
    return "currentdoc is null or empty";
  }
  try {
    await conn.collection('Sales Reporting').doc(currentdoc).delete();
    currentdoc = null;
    _currentdocController.add(currentdoc!);
    return "Sales Report Deleted";

  } catch (e) {
    print(e.toString());
    return "Error Deleting Sales Report";
  }
}

Future<void> autoUpdateSalesReport(int sales, double revenue) async {
  if (currentdoc == null) {
    print('currentdoc is null');
    return;
  }
  try {
    await conn.collection('Sales Reporting').doc(currentdoc).update({
      'Sales': FieldValue.increment(sales),
      'Total Revenue': FieldValue.increment(revenue),
    });
  } catch (e) {
    print(e.toString());
  }
}

Future<void> deleteAllSalesReport() async {
  try {
    QuerySnapshot querySnapshot = await conn.collection('Sales Reporting').get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    currentdoc = null;
    _currentdocController.add(currentdoc!);
  } catch (e) {
    print(e.toString());
  }
}

void dispose() {
  _currentdocController.close();

}

 Future<bool> getIsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isEnabled') ?? false;
  }

}