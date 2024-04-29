import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_service.dart';
import 'firestore_service.dart' as firestore_service;

class TransactionService{
Future<String> addTransaction(DateTime datetime, int phone, double amount, CartModel cart) async {
  try {
    final transactionRef = firestore_service.db.collection('Transaction');
    DocumentReference docRef = await transactionRef.add({
      'Datetime': datetime,
      'Phone Number': phone,
      'Amount': amount,
      'Items': cart.items,
    });

    final productRef = firestore_service.db.collection('Product');
    for (var entry in cart.items.entries) {
      var productQuery = await productRef.where('Name', isEqualTo: entry.key).get();
      if (productQuery.docs.isNotEmpty) {
        var productDoc = productQuery.docs.first;
        var currentQuantity = int.parse(productDoc.data()['Quantity'] as String);
        var timesSold = productDoc.data()['Times Sold'] != null ? productDoc.data()['Times Sold'] as int : 0;
        await productDoc.reference.update({
          'Quantity': (currentQuantity - entry.value).toString(),
          'Times Sold': timesSold + entry.value,
        });
      }
    }

    return docRef.id;
  } catch (e) {
    print(e);
    return 'Failed to add transaction';
  }
}

Future<void> deleteTransaction(String docId) async {
  try {
    final transactionRef = firestore_service.db.collection('Transaction').doc(docId);
    await transactionRef.delete();
  } catch (e) {
    print(e);
  }
}

Future<void> updateTransaction(String docId, Map<String, dynamic> data) async {
  try {
    final transactionRef = firestore_service.db.collection('Transaction').doc(docId);
    await transactionRef.update(data);
  } catch (e) {
    print(e);
  }
}

Future<void> clearAllTransactions() async {
  try {
    final transactionRef = firestore_service.db.collection('Transaction');
    QuerySnapshot querySnapshot = await transactionRef.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    print(e);
  }
}



}