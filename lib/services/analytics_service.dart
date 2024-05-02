import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';

class AnalyticsService {
 final conn = db;
 String? currentdoc;

 static final AnalyticsService _singleton = AnalyticsService._internal();

  factory AnalyticsService() {
    return _singleton;
  }
 
  AnalyticsService._internal();

Future<void> createSalesReport() async {
  try {
    DocumentReference docRef = await conn.collection('Sales Reporting').add({
      'Sales': 0,
      'Total Revenue': 0,
    });
    currentdoc = docRef.id;
    print("Current Sales Report ID: $currentdoc");
  } catch (e) {
    print(e.toString());
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

Future<void> deleteSalesReport() async {
    if (currentdoc!.isEmpty) {
    print('currentdoc is null or empty');
    return;
  }
  try {
    await conn.collection('Sales Reporting').doc(currentdoc).delete();
  } catch (e) {
    print(e.toString());
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
  } catch (e) {
    print(e.toString());
  }
}

}