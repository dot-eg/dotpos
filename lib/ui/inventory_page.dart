import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'product_page.dart';
import 'text_styles.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<String> selectedProducts = [];
  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Positioned(
            //Background
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/backgrounds/products_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.625,
            top: 0 ,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.375,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            //Inventory Header
            left: MediaQuery.of(context).size.width * 0.01953125,
            top: MediaQuery.of(context).size.height * 0.0298913,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9609375,
              height: MediaQuery.of(context).size.height * 0.08369565,
              child: Text('Inventory', style: productspageHeaders),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.8984375,
            top: MediaQuery.of(context).size.height * 0.02005348,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        child: SizedBox(
                      width: 500,
                      height: 350,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 20,
                            child: SizedBox(
                                width: 150,
                                height: 30,
                                child: Text('Add Product',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Hind Kochi'))),
                          ),
                          Positioned(
                            left: 20,
                            top: 50,
                            child: SizedBox(
                              width: 450,
                              height: 60,
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Product Name',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 100,
                            child: SizedBox(
                              width: 450,
                              height: 60,
                              child: TextField(
                                controller: skuController,
                                decoration: InputDecoration(
                                  labelText: 'SKU',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 150,
                            child: SizedBox(
                              width: 450,
                              height: 60,
                              child: TextField(
                                controller: priceController,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 200,
                            child: SizedBox(
                              width: 450,
                              height: 60,
                              child: TextField(
                                controller: quantityController,
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 300,
                            left: 190,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    String result = await addProduct(
                                        nameController.text,
                                        skuController.text,
                                        int.parse(priceController.text),
                                        quantityController.text);
                                    if (result.contains("Success")) {
                                      products = [];
                                      List<String> newProducts =
                                          await retrieveProductName();
                                      setState(() {
                                        products = newProducts;
                                      });
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text(
                                                'An error occurred while adding the product.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
                  },
                );
              },
              icon: Icon(Icons.add_circle,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.03125),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.9375,
            top: MediaQuery.of(context).size.height * 0.02005348,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete Products'),
                      content: Text(
                          'Are you sure you want to delete the selected products?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            for (String product in selectedProducts) {
                              deleteProduct(productMap[product]!);
                            }
                            selectedProducts = [];
                            products = [];
                            List<String> newProducts =
                                await retrieveProductName();
                            setState(() {
                              products = newProducts;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.remove_circle,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.03125),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.84765625,
            top: MediaQuery.of(context).size.height * 0.01069519,
            child: IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.edit_attributes,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.04296875),
            ),
          ),
          Positioned(
            //Products Grid
            left: MediaQuery.of(context).size.width * 0.01953125,
            top: MediaQuery.of(context).size.height * 0.1135217,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5859375,
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (selectedProducts.contains(products[index])) {
                        setState(() {
                          selectedProducts.remove(products[index]);
                        });
                      } else {
                        setState(() {
                          selectedProducts.add(products[index]);
                        });
                      }
                    },
                    onLongPress: () {
                      String selected = productMap[products[index]]!;
                      openProductPage(context, selected);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: selectedProducts.contains(products[index])
                          ? BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            )
                          : BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                      child: Text(products[index], style: productsGrid),
                    ),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
