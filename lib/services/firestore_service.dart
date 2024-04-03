import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;
List<String> products = [];
List<String> productIds = [];
Map<String, String> productMap = {};

Future<List<String>> retrieveProductName() async {
  try {
    final collectionRef = db.collection('Product');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;
      products.add(data['Name'] as String);
    }
    print(products);
    return products;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<String>> retrieveProductIds() async {
  try {
    final collectionRef = db.collection('Product');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      productIds.add(doc.id);
    }
    print(productIds);
    return productIds;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<Map<String, dynamic>> retrieveProductData(String docId) async {
  try {
    final docRef = db.collection('Product').doc(docId);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    print(data);
    return data;
  } catch (e) {
    print(e);
    return {};
  }
}

Future<Map<String, String>> createProductMap() async {
  List<String> names = await retrieveProductName();
  List<String> ids = await retrieveProductIds();

  if (names.length != ids.length) {
    throw Exception('Mismatch between product names and IDs');
  }

  for (int i = 0; i < names.length; i++) {
    productMap[names[i]] = ids[i];
  }

  return productMap;
}