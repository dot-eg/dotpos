import 'cart_service.dart';
import 'firestore_service.dart' as firestore_service;

Future<String> addTransaction(DateTime datetime, int customer_ID, int amount, CartModel cart) async {
  try {
    final transactionRef = firestore_service.db.collection('Transaction');
    await transactionRef.add({
      'Datetime': datetime,
      'Customer_ID': customer_ID,
      'Amount': amount,
      'Items': cart.items,
    });
    return transactionRef.id;
  } catch (e) {
    print(e);
    return 'Failed to add transaction';
  }
}