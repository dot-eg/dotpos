import 'package:dotpos/services/navi_service.dart';
import 'package:dotpos/ui/product_home_page.dart';
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

class CheckoutPage extends StatelessWidget{
  final CartModel cart;

  CheckoutPage({Key? key, required this.cart}) : super(key: key);

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
                                top: 72,
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
                                                    height: 31,
                                                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
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