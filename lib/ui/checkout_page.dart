import 'package:dotpos/services/navi_service.dart';
import 'package:flutter/material.dart';
import '../ui/text_styles.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';


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

class _CheckoutPageState extends State<CheckoutPage>{
  String MethoddropdownValue = 'Cash';
  String TaxesdropdownValue = '15%';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerIDController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  double changeDue = 0;

  @override
  void initState(){
    super.initState();
    _amountController.addListener(calculateChangeDue);
  }

  void calculateChangeDue(){
    print('Calculating change due');
    print(_amountController.text);
    setState(() {
      if (_amountController.text.isNotEmpty && isNumeric(_amountController.text)) {
        changeDue = double.parse(_amountController.text) - widget.cart.getTotal();
      } else {
        changeDue = -widget.cart.getTotal();
      }
    });
    print(changeDue);
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  void dispose(){
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _customerIDController.dispose();
    _amountController.dispose();
    _amountController.removeListener(calculateChangeDue);
    super.dispose();
  }

  @override

  Widget build(BuildContext context){
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
                            image: AssetImage('assets/images/backgrounds/products_bg.jpg'),
                            fit: BoxFit.fill,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 908,
                    height:screenSize.height,
                    decoration: BoxDecoration(color: Colors.white),
                ),
            ),
            Positioned(
                left: 947,
                top: 32,
                child: SizedBox(
                    width: 174,
                    height: 48,
                    child: Text(
                        'Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w400,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 32,
                top: 32,
                child: Row(children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => CurrentPage()
                    ), 
                  ),
                ),
                  SizedBox(
                    width: 174,
                    height: 48,
                    child: Text(
                        'Checkout',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w400,
                            height: 0,
                        ),
                    ),
                ),
                ],
                )  
            ),
            Positioned(
                left: 32,
                top: 101,
                child: SizedBox(
                    width: 150,
                    height: 29,
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
                left: 32,
                top: 303,
                child: SizedBox(
                    width: 150,
                    height: 29,
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
                left: 32,
                top: 130,
                child: SizedBox(
                    width: 591,
                    height: 125,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                    width: 270,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                    width: 270,
                                                    height: 31,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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
                                    width: 270,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                    width: 270,
                                                    height: 31,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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
                                    width: 270,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                    width: 270,
                                                    height: 31,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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
                                    width: 270,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                    width: 270,
                                                    height: 31,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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
                                    width: 270,
                                    height: 54,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 23,
                                                child: Container(
                                                    width: 270,
                                                    height: 31,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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
                left: 32,
                top: 330,
                child: SizedBox(
                    width: 591,
                    height: 150,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                    width: 270,
                                    height: 70,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                width: 270, // Set the width as needed
                                                height: 41,
                                                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: DropdownButton<String>(
                                                    isExpanded: true, // This will make the dropdown menu item take the full width of its parent
                                                    value: MethoddropdownValue,
                                                    icon: const Icon(Icons.arrow_drop_down),
                                                    iconSize: 24,
                                                    style: const TextStyle(color: Colors.deepPurple),
                                                    underline: Container(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        MethoddropdownValue = newValue!;
                                                      });
                                                    },
                                                    items: <String>['Cash', 'Credit Card', 'Mobile Wallet']
                                                        .map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value, style: TextStyle(color: Colors.black)),
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
                                    width: 270,
                                    height: 70,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                width: 270, // Set the width as needed
                                                height: 41,
                                                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: DropdownButton<String>(
                                                    isExpanded: true, // This will make the dropdown menu item take the full width of its parent
                                                    value: TaxesdropdownValue,
                                                    icon: const Icon(Icons.arrow_drop_down),
                                                    iconSize: 24,
                                                    style: const TextStyle(color: Colors.deepPurple),
                                                    underline: Container(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        TaxesdropdownValue = newValue!;
                                                      });
                                                    },
                                                    items: <String>['No Tax', '15%']
                                                        .map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value, style: TextStyle(color: Colors.black)),
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
                                    width: 270,
                                    height: 70,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                    width: 270,
                                                    height: 41,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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
                                    width: 270,
                                    height: 64,
                                    child: Stack(
                                        children: [
                                            Positioned(
                                                left: 0,
                                                top: 0,
                                                child: SizedBox(
                                                    width: 150,
                                                    height: 23,
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
                                                    width: 270,
                                                    height: 41,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                                                    child: TextField(
                                                      controller: _amountController,
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        contentPadding: EdgeInsets.all(8.0),
                                                      ),
                                                    ),
                                                ),
                                            ),
        ],
    ),
)
), 
                        ],
),
),
),
Positioned(
              left: 940,
              top: 75,
              child: SizedBox(
                width: 560,
                height: 700,
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              var itemEntry = cart.items.entries.elementAt(index);
                              return FutureBuilder<double>(
                                future: Future.value(cart.getPrice(itemEntry.key)),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            itemEntry.key,
                                            style: cartList,
                                          ),
                                          Text(
                                            'Quantity: ${itemEntry.value} | Price: EGP ${snapshot.data}',
                                            style: cartList.copyWith(fontSize: 12.0),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.remove, color: Colors.white),
                                        onPressed: () {
                                          Provider.of<CartModel>(context, listen: false).remove(itemEntry.key);
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
                          color: Colors.white, // Adjust the color as needed
                          thickness: 1.0, // Adjust the thickness as needed
                          ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0), // Adjust the value as needed
                          child: Align(
                            alignment: Alignment(-1, 0.0),
                            child: Text(
                              'Total EGP ${cart.getTotal()}',
                              style: productspageHeaders.copyWith(fontSize: 20.0),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white, // Adjust the color as needed
                          thickness: 1.0, // Adjust the thickness as needed
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
    )
),
    );

  }  
}