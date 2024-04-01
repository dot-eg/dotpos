import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;
List<String> products = [];

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

// List<String> productsN = [
//   'Apple', 'Product 2', 'Product 3', 'Product 4','Product 5',
//   'Product 6', 'Product 7', 'Product 8', 'Product 9','Product 10',
//   'Product 11', 'Product 12', 'Product 13', 'Product 14','Product 15'
//   ];


  //to be replaced with firebase firestore database of products