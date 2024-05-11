import 'package:dotpos/services/navi_service.dart';
import 'package:flutter/material.dart';
import '../ui/text_styles.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../services/trans_service.dart';
import '../services/firestore_service.dart' as firestore_service;
import '../services/reciept_service.dart';

void openCheckoutPage(context, CartModel cart) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => CheckoutPage(cart: cart),
    ),
  );
}

class CheckoutPage extends StatefulWidget {
  final CartModel cart;

  CheckoutPage({Key? key, required this.cart}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ReceiptService receiptService = ReceiptService();
  final TransactionService transactionService = TransactionService();
  String MethoddropdownValue = 'Cash';
  String TaxesdropdownValue = '15%';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerIDController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  double changeDue = 0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(calculateChangeDue);
    _phoneController.addListener(() {
      getInfobyPhone(_phoneController.text);
    });
    // _customerIDController.addListener(() {
    //   getInfobyID(_customerIDController.text);
    // });
  }

  void calculateChangeDue() {
    print('Calculating change due');
    print(_amountController.text);
    setState(() {
      if (_amountController.text.isNotEmpty &&
          isNumeric(_amountController.text)) {
        changeDue = double.parse(_amountController.text) -
            widget.cart.getTotal() * 1.15;
      } else {
        changeDue = 0;
      }
    });
    print(changeDue);
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  void getInfobyPhone(String phone) async {
    final customerRef = firestore_service.db.collection('Customer');
    final customerDoc =
        await customerRef.where('Phone_no', isEqualTo: phone).get();
    if (customerDoc.docs.isNotEmpty) {
      final customerData = customerDoc.docs.first.data();
      _nameController.text = customerData['Name'];
      _emailController.text = customerData['Email'];
      _customerIDController.text = customerDoc.docs.first.id;
    }
  }

  void getInfobyID(String id) async {
    if (id.isNotEmpty) {
      final customerRef = firestore_service.db.collection('Customer');
      final customerDoc = await customerRef.doc(id).get();
      if (customerDoc.exists) {
        final customerData = customerDoc.data();
        setState(() {
          _nameController.text = customerData?['Name'];
          _emailController.text = customerData?['Email'];
          _phoneController.text = customerData?['Phone_no'];
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _customerIDController.dispose();
    _amountController.dispose();
    _amountController.removeListener(calculateChangeDue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/backgrounds/products_bg.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: screenSize.width * 0.59114583,
                height: screenSize.height,
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.61653646,
              top: screenSize.height * 0.04036327,
              child: SizedBox(
                width: screenSize.width * 0.11328125,
                height: screenSize.height * 0.05045409,
                child: Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.width * 0.01953125,
                    fontFamily: 'Hind Kochi',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
                left: screenSize.width * 0.02083333,
                top: screenSize.height * 0.04036327,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Colors.black,
                          size: screenSize.width * 0.01953125),
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => CurrentPage()),
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.11328125,
                      height: screenSize.height * 0.05045409,
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenSize.width * 0.01953125,
                          fontFamily: 'Hind Kochi',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              left: screenSize.width * 0.02083333,
              top: screenSize.height * 0.12739657,
              child: SizedBox(
                width: screenSize.width * 0.13020833,
                height: screenSize.height * 0.03657921,
                child: Text(
                  'Customer Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Hind Kochi',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.02083333,
              top: screenSize.height * 0.38218971,
              child: SizedBox(
                width: screenSize.width * 0.1171875,
                height: screenSize.height * 0.03657921,
                child: Text(
                  'Payment Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Hind Kochi',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.02083333,
              top: screenSize.height * 0.16397578,
              child: SizedBox(
                width: screenSize.width * 0.43,
                height: screenSize.height * 0.18920283,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: screenSize.height * 0.09460141,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Customer ID',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width * 0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration:
                                    BoxDecoration(color: Color(0xFFD9D9D9)),
                                child: TextField(
                                  controller: _customerIDController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 71,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: screenSize.height * 0.08829465,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width * 0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration:
                                    BoxDecoration(color: Color(0xFFD9D9D9)),
                                child: TextField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 321,
                      top: 71,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width * 0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration:
                                    BoxDecoration(color: Color(0xFFD9D9D9)),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 321,
                      top: 0,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width * 0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration:
                                    BoxDecoration(color: Color(0xFFD9D9D9)),
                                child: TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.02083333,
              top: screenSize.height * 0.41624622,
              child: SizedBox(
                width: screenSize.width * 0.43,
                height: screenSize.height * 0.18920283,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: screenSize.height * 0.08829465,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Method',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width *
                                    0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    isExpanded:
                                        true,
                                    value: MethoddropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        MethoddropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Cash',
                                      'Credit Card',
                                      'Mobile Wallet'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 72,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Taxes',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width *
                                    0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    isExpanded:
                                        true,
                                    value: TaxesdropdownValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        TaxesdropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>['15%']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 321,
                      top: 71,
                      child: SizedBox(
                        width: screenSize.width * 0.17578125,
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: screenSize.width * 0.09765625,
                                height: screenSize.height * 0.0290111,
                                child: Text(
                                  'Change Due',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Hind Kochi',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 23,
                              child: Container(
                                width: screenSize.width * 0.17578125,
                                height: screenSize.height * 0.05171544,
                                decoration:
                                    BoxDecoration(color: Color(0xFFD9D9D9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(changeDue.toString()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        left: 321,
                        top: 0,
                        child: SizedBox(
                          width: screenSize.width * 0.17578125,
                          height: 64,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: screenSize.width * 0.09765625,
                                  height: screenSize.height * 0.0290111,
                                  child: Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Hind Kochi',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 23,
                                child: Container(
                                  width: screenSize.width * 0.17578125,
                                  height: screenSize.height * 0.05171544,
                                  decoration:
                                      BoxDecoration(color: Color(0xFFD9D9D9)),
                                  child: TextField(
                                    controller: _amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(8.0),
                                      hintText: 'Enter amount',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.61197917,
              top: screenSize.height * 0.09460141,
              child: SizedBox(
                width: screenSize.width * 0.38411458,
                height: screenSize.height * 0.88294652,
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              var itemEntry =
                                  cart.items.entries.elementAt(index);
                              return FutureBuilder<double>(
                                future:
                                    Future.value(cart.getPrice(itemEntry.key)),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            itemEntry.key,
                                            style: cartList,
                                          ),
                                          Text(
                                            'Quantity: ${itemEntry.value} | Price: EGP ${snapshot.data}',
                                            style: cartList.copyWith(
                                                fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.remove,
                                            color: Colors.white),
                                        onPressed: () {
                                          Provider.of<CartModel>(context,
                                                  listen: false)
                                              .remove(itemEntry.key);
                                        },
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.0),
                          child: Align(
                            alignment: Alignment(-1, 0.0),
                            child: Text(
                              'Subtotal EGP ${cart.getTotal()}',
                              style:
                                  productspageHeaders.copyWith(fontSize: 20.0),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.0),
                          child: Align(
                            alignment: Alignment(-1, 0.0),
                            child: Text(
                              'Taxes EGP ${cart.getTotal() * 0.15}',
                              style:
                                  productspageHeaders.copyWith(fontSize: 20.0),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1.0, 
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5.0),
                          child: Align(
                            alignment: Alignment(-1, 0.0),
                            child: Text(
                              'Total due EGP ${cart.getTotal() * 1.15}',
                              style: productspageHeaders.copyWith(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * 0.02083333,
              top: screenSize.height * 0.88294652,
              child: SizedBox(
                  width: screenSize.width * 0.13020833,
                  height: screenSize.height * 0.06306761,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _phoneController.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill in all the fields.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        bool customerExists = await firestore_service.customerExists(_phoneController.text);
                        if (!customerExists){
                          await firestore_service.addCustomer(_nameController.text, _emailController.text, _phoneController.text);
                        }
                        String transactionid =
                            await transactionService.addTransaction(
                          DateTime.now(),
                          int.parse(_phoneController.text),
                          widget.cart.getTotal() * 1.15,
                          widget.cart,
                        );
                        if (transactionid != 'Failed to add transaction') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Transaction Successful'),
                                icon: Icon(Icons.check_circle,
                                    color: Colors.green),
                                content: Text('Transaction ID: $transactionid'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CurrentPage()),
                                      );
                                      Provider.of<CartModel>(context,
                                              listen: false)
                                          .clear();
                                    },
                                    child: Text('OK'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      receiptService.generateReceipt(
                                        context,
                                        transactionid,
                                        _nameController.text,
                                        _emailController.text,
                                        _phoneController.text,
                                        widget.cart,
                                      );
                                    },
                                    child: Text('Print Receipt'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text('Complete Transaction',
                        style: TextStyle(
                            fontFamily: 'Hind Kochi',
                            fontSize: screenSize.width * 0.00976562,
                            color: Colors.black)),
                  )),
            ),
            Positioned(
              left: screenSize.width * 0.16276042,
              top: screenSize.height * 0.88294652,
              child: SizedBox(
                  width: screenSize.width * 0.13020833,
                  height: screenSize.height * 0.06306761,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => CurrentPage()),
                      );
                      Provider.of<CartModel>(context, listen: false).clear();
                    },
                    child: Text('Disregard Transaction',
                        style: TextStyle(
                            fontFamily: 'Hind Kochi',
                            fontSize: screenSize.width * 0.00976562,
                            color: Colors.white)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
