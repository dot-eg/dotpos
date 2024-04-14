import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


var db = FirebaseFirestore.instance;
List<String> products = [];
List<String> productIds = [];
List<String> customerIds = [];
List<String> customers = [];
Map<String, String> productMap = {};
Map<String, String> customerMap = {};

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
    final PdocRef = db.collection('Product').doc(docId);
    DocumentSnapshot Productdoc = await PdocRef.get();
    final Productdata = Productdoc.data() as Map<String, dynamic>;
    print(Productdata);
    return Productdata;
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

//---------------------------------------------------------------------------------------

Future<List<String>> retrieveCustomerIds() async {
  try {
    final collectionRef = db.collection('Customer');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      customerIds.add(doc.id);
    }
    print(customerIds);
    return customerIds;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<String>> retrieveCustomerName() async {
  try {
    final collectionRef = db.collection('Customer');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;
      customers.add(data['Name'] as String);
    }
    print(customers);
    return customers;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<Map<String, dynamic>> retrieveCustomerData(String docId) async {
  try {
    final CdocRef = db.collection('Customer').doc(docId);
    DocumentSnapshot customerdoc = await CdocRef.get();
    final customerdata = customerdoc.data() as Map<String, dynamic>;
    print(customerdata);
    return customerdata;
  } catch (e) {
    print(e);
    return {};
  }
}

Future<Map<String, String>> createCustomerMap() async {
  List<String> names = await retrieveCustomerName();
  List<String> ids = await retrieveCustomerIds();

  if (names.length != ids.length) {
    throw Exception('Mismatch between customer names and IDs');
  }

  for (int i = 0; i < names.length; i++) {
    customerMap[names[i]] = ids[i];
  }

  return customerMap;
}

Future<String> addCustomer(String name, String email, String phone) async {
  try {
    DocumentReference customerRef =  await db.collection('Customer').add({
      'Name': name,
      'Email': email,
      'Phone_no': phone,
    });

    return customerRef.id;

  } catch (e) {
    print(e);
    rethrow;
  }
}


Future<List<Map<String, dynamic>>> retrieveAllTransactions({String? date, String? customerId}) async {
  try {
    Query query = db.collection('Transaction');

    if (date != null) {
      DateTime selectedDate = DateFormat('yyyy-MM-dd').parse(date);
      DateTime nextDay = selectedDate.add(Duration(days: 1));

      query = query.where('Datetime', isGreaterThanOrEqualTo: Timestamp.fromDate(selectedDate))
                   .where('Datetime', isLessThan: Timestamp.fromDate(nextDay));
    }

    if (customerId != null) {
      query = query.where('Customer_ID', isEqualTo: customerId);
    }

    QuerySnapshot querySnapshot = await query.get();
    List<Map<String, dynamic>> transactions = querySnapshot.docs.map((doc) => doc.data()).toList().cast<Map<String, dynamic>>();
    print(transactions);
    return transactions;
  } catch (e) {
    print(e);
    rethrow;
  }
}


void retrieveAllData() async {
  await createProductMap();
  await createCustomerMap();
}

void refreshAllData() async {
  products = [];
  productIds = [];
  customerIds = [];
  customers = [];
  productMap = {};
  customerMap = {};
  await createProductMap();
  await createCustomerMap();
}

class User {
  final String uid;
  final String email;
  // Add more fields as needed

  User({
    required this.uid,
    required this.email,
    // Add more fields as needed
  });
}

Future<String> addProduct(String name, String sku , int price, String quantity) async {
  try {
    DocumentReference productRef =  await db.collection('Product').add({
      'Name': name,
      'SKU' : sku,
      'Price': price,
      'Quantity': quantity,
    });

    return 'Success ${productRef.id}';

  } catch (e) {
    print(e);
    rethrow;
  }
}

Future<String> updateProduct(String docId, String name, String sku ,String price, String quantity) async {
  try {
    await db.collection('Product').doc(docId).update({
      'Name': name,
      'SKU' : sku,
      'Price': price,
      'Quantity': quantity,
    });
    return "Success";

  } catch (e) {
    print(e);
    return "Error";
  }
}

Future<String> deleteProduct(String docId) async {
  try {
    await db.collection('Product').doc(docId).delete();
    return "Success";

  } catch (e) {
    print(e);
    return "Error";
  }
}

Future<String> updateQuantity(String docId, String quantity) async {
  try {
    await db.collection('Product').doc(docId).update({
      'Quantity': quantity,
    });
    return "Success";

  } catch (e) {
    print(e);
    return "Error";
  }
}