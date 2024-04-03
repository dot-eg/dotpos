import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../services/cart_service.dart';
import 'package:provider/provider.dart';


void openProductPage(BuildContext context, String docId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FutureBuilder<Map<String, dynamic>>(
        future: retrieveProductData(docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ProductPage(productData: snapshot.data!);
          }
        },
      ),
    ),
  );
}

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> productData;

  ProductPage({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productData['Name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${productData['Name'] ?? 'Default Name'}'),
            Text('Price: ${productData['Price'] ?? 'Default Name'}'),
            // Add more fields as needed
            ElevatedButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).add(productData['Name']);
                Navigator.pop(context);
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}