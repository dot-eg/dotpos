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
        width: 1528,
        height: 742,
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
left: 972,
top: 76,
child: Container(
width: 503,
height: 480,
decoration: BoxDecoration(
image: DecorationImage(
image: NetworkImage("https://via.placeholder.com/503x480"),
fit: BoxFit.fill,
),
),
),
),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 913,
                height: 742,
                decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4000000059604645),
                ),
              ),
            ),
            Positioned(
              left: 65,
              top: 266,
              child: Container(
                        width: 913,
                        height: 742,
                        child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SizedBox(
                              width: 238,
                              height: 34,
                              child: Text(
                                'SKU:${productData['SKU'] ?? 'Default'}',
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
                            top: 34,
                            child: SizedBox(
                              width: 238,
                              height: 32,
                              child: Text(
                                'Price:${productData['Price'] ?? 'Default'}',
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
                          top: 66,
                          child: SizedBox(
                          width: 238,
                          height: 30,
                          child: Text(
                          'Available Quantity: ${productData['Qty'] ?? 'Default'}',
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
                          child: Container(
                          width: 583,
                          height: 134,
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
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam molestie luctus tellus sagittis aliquam. Duis eu justo urna. Nunc dictum nisi et ante vehicula scelerisque. Nullam sit amet nisl eu tellus aliquam dictum eu rhoncus magna. Phasellus porttitor nisi non enim rutrum, et efficitur nibh dignissim.',
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
              top: 545,
              child: Container(
              width: 226,
              height: 36,
              child: Stack(
              children: [
              Positioned(
              left: 59,
              top: 5,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false).add(productData['Name']);
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

// Positioned(
//               top: 10,
//               left: 10,
//               child: Text('Name: ${productData['Name'] ?? 'Default Name'}'),
//             ),
//             Positioned(
//               top: 30,
//               left: 10,
//               child: Text('Price: ${productData['Price'] ?? 'Default Name'}'),
//             ),
//             // Add more 