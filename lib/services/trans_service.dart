import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_service.dart';
import 'firestore_service.dart' as firestore_service;

Future<String> addTransaction(DateTime datetime, int customer_ID, double amount, CartModel cart) async {
  try {
    final transactionRef = firestore_service.db.collection('Transaction');
    DocumentReference docRef = await transactionRef.add({
      'Datetime': datetime,
      'Customer_ID': customer_ID,
      'Amount': amount,
      'Items': cart.items,
    });
    return docRef.id;
  } catch (e) {
    print(e);
    return 'Failed to add transaction';
  }
}