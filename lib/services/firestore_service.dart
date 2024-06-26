import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotpos/services/notification_service.dart';
import 'package:intl/intl.dart';
import "analytics_service.dart";
import "dart:async";

var db = FirebaseFirestore.instance;
List<String> userIDs = [];
List<String> users = [];
List<String> products = [];
List<String> productIds = [];
List<String> customerIds = [];
List<String> customers = [];
Map<String, String> usermap = {};
Map<String, String> productMap = {};
Map<String, String> customerMap = {};
List<String> outofstock = [];
List<String> lowquantity = [];

Future<List<String>> retreiveUserIDs() async {
  try {
    final collectionRef = db.collection('User');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      userIDs.add(doc.id);
    }
    print(userIDs);
    return userIDs;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<String>> getuserNames() async {
  try {
    final collectionRef = db.collection('User');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;
      users.add(data['DisplayName'] as String);
    }
    print(users);
    return users;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<Map<String, String>> createUserMap() async {
  List<String> names = await getuserNames();
  List<String> ids = await retreiveUserIDs();

  if (names.length != ids.length) {
    throw Exception('Mismatch between user names and IDs');
  }

  for (int i = 0; i < names.length; i++) {
    usermap[names[i]] = ids[i];
  }

  return usermap;
}


Future<Map<String, dynamic>> retrieveUserData(String docId) async {
  try {
    final UdocRef = db.collection('User').doc(docId);
    DocumentSnapshot userdoc = await UdocRef.get();
    final userdata = userdoc.data() as Map<String, dynamic>;
    print(userdata);
    return userdata;
  } catch (e) {
    print(e);
    return {};
  }
}

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
    List<Map<String, dynamic>> transactions = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>? ?? {};
      data['id'] = doc.id;
      return data;
    }).toList().cast<Map<String, dynamic>>();
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
  await getOutofStock();
  await createUserMap();
  await getlowquantity();
}

void refreshAllData() async {
  products.clear();
  productIds.clear();
  customerIds.clear();
  customers.clear();
  productMap.clear();
  customerMap.clear();
  outofstock.clear();
  await createProductMap();
  await createCustomerMap();
  await getOutofStock();
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

Future<Map<String, dynamic>> retrieveTransactionData(String docId) async {
  try {
    final TdocRef = db.collection('Transaction').doc(docId);
    DocumentSnapshot Transdoc = await TdocRef.get();
    final Transdata = Transdoc.data() as Map<String, dynamic>;
    print(Transdata);
    return Transdata;
  } catch (e) {
    print(e);
    return {};
  }
}

Future<List<String>> getOutofStock() async {
  try {
    final collectionRef = db.collection('Product');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;
      int quantity = int.parse(data['Quantity']);
      if(quantity == 0){
        outofstock.add(data['Name'] as String);
      }
    }
    print(outofstock);
    return outofstock;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<String>> getlowquantity() async {
  NotificationService notificationService = NotificationService();
  try {
    String num = await notificationService.getQuantityThreshold();
    int number = int.parse(num); 
    print("Quantity Threshold : $number");
    final collectionRef = db.collection('Product');
    QuerySnapshot querySnapshot = await collectionRef.get();
    lowquantity.clear();
    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;
      int quantity = int.parse(data['Quantity']);
      if(quantity < number){
        lowquantity.add(data['Name'] as String);
      }
    }
    print("LowQuantity : $lowquantity");
    return lowquantity;
  } catch (e) {
    print(e);
    return [];
  }
}


Future<bool> customerExists(String phone) async {
  try {
    final collectionRef = db.collection('Customer');
    QuerySnapshot querySnapshot = await collectionRef.get();
    for(var doc in querySnapshot.docs){
      final data = doc.data() as Map<String, dynamic>;
      if(data['Phone_no'] == phone){
        return true;
      }
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

Stream<QuerySnapshot> getMostSoldProducts() {
    return db
      .collection('Product')
      .orderBy('Times Sold', descending: true)
      .snapshots();
  }

Stream<DocumentSnapshot> getSalesReport() {
  return db
    .collection('Sales Reporting')
    .doc(AnalyticsService().currentdoc)
    .snapshots();
}


    