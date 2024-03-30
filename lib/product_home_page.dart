import 'package:flutter/material.dart';
import 'cart_model.dart';
import 'package:provider/provider.dart';
import 'products.dart';

class ProductHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
    width: 1920,
    height: 1080,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 1920,
                    height: 1080,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1554034483-04fda0d3507b?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                            fit: BoxFit.fill,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 1014,
                top: 0,
                child: Container(
                    width: 522,
                    height: 1000,
                    decoration: BoxDecoration(color: Color(0xB29A9393).withOpacity(0.5)),
                ),
            ),
            Positioned(
                left: 548,
                top: 22,
                child: Container(
                    width: 427,
                    height: 67,
                    decoration: ShapeDecoration(
                        color: Color(0x66D9D9D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ))
                    
                ),
            ),
            Positioned(
                left: 44,
                top: 37,
                child: SizedBox(
                    width: 246,
                    height: 38,
                    child: Text(
                        'Your Products',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w300,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 1044,
                top: 37,
                child: SizedBox(
                    width: 246,
                    height: 38,
                    child: Text(
                        'Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w300,
                            height: 0,
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 1040,
                top: 625,
                child: SizedBox(
                    width: 221,
                    height: 46,
                    child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartModel>(context, listen: false).clear();
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete_forever),
                        SizedBox(width: 10),
                        Text(
                        'Clear',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w300,
                            height: 0,
                        ),
                      ),
                      ],
                    ),
                    )
                ),
            ),
            Positioned(
                left: 1285,
                top: 625,
                child: SizedBox(
                    width: 221,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () => print("Button pressed"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.credit_card),
                        SizedBox(width: 10),
                        Text(
                        'Checkout',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Hind Kochi',
                            fontWeight: FontWeight.w300,
                            height: 0,
                        ),
                      ),
                      ],
                    ),
                    )
                ),
            ),
           Positioned(
              left: 1050,
              top: 75, // Adjust the position as needed
              child: SizedBox(
                width: 400, // Adjust the size as needed
                height: 500, // Adjust the size as needed
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    return ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            cart.items[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Hind Kochi',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
           Positioned(
  left: 30,
  top: 90,
  child: SizedBox(
    width: 950, // Adjust the size as needed
    height: 1000, // Adjust the size as needed
    child: GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Adjust the number of items per row as needed
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<CartModel>(context, listen: false).add(products[index]);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              products[index],
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    ),
  ),
),  
        ],
    ),
)
    );
  }
}