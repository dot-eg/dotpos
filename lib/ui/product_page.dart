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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/products_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: MediaQuery.of(context).size.width*0.65,
              top: MediaQuery.of(context).size.height*0.1,
              child: Container(
                width: MediaQuery.of(context).size.width*0.3,
                height: MediaQuery.of(context).size.height*0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(productData['ImageURL'] ?? 'https://via.placeholder.com/150'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4000000059604645),
                ),
              ),
            ),
            Positioned(
              left: 65,
              top: 266,
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                height: MediaQuery.of(context).size.height*0.2,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 238,
                        height: 53,
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 38,
                      child: SizedBox(
                        width: 238,
                        height: 34,
                        child: Text(
                          'SKU: ${productData['SKU'] ?? 'Default'}',
                          style: TextStyle(
                            color: Colors.white,
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
                      top: 64,
                      child: SizedBox(
                        width: 238,
                        height: 32,
                        child: Text(
                          'Price: EGP ${productData['Price'] ?? 'Default'}',
                          style: TextStyle(
                            color: Colors.white,
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
                      top: 90,
                      child: SizedBox(
                        width: 238,
                        height: 30,
                        child: Text(
                          'Available Quantity: ${productData['Quantity'] ?? 'Default'}',
                          style: TextStyle(
                            color: Colors.white,
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
                      top: 116,
                      child: SizedBox(
                        width: 238,
                        height: 30,
                        child: Text(
                          'Times Sold: ${productData['Times Sold'] ?? 'Untracked'}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 65,
              top: 63,
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                height: MediaQuery.of(context).size.height*0.2,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 238,
                        height: 53,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    
                    Positioned(
                      left: 0,
                      top: 44,
                      child: SizedBox(
                        width: 583,
                        height: 90,
                        child: Text(
                          productData['Description'] ?? 'Default Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width*0.001,
              top: MediaQuery.of(context).size.height*0.8,
              child: SizedBox(
                width: 226,
                height: 36,
                child: Stack(
                  children: [
                    Positioned(
                      left: 59,
                      top: 5,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .add(productData['Name']);
                          Navigator.pop(context);
                        },
                        child: Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}