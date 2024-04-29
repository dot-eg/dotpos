import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_page.dart';
import 'text_styles.dart';
import 'package:fl_chart/fl_chart.dart';

List<Color> gradientColors = [
  Color(0xff23b6e6),
  Color(0xff02d39a),
];

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
  final newquantityController = TextEditingController();

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
            top: 0,
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
            //Inventory Header
            left: MediaQuery.of(context).size.width * 0.640625,
            top: MediaQuery.of(context).size.height * 0.0298913,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9609375,
              height: MediaQuery.of(context).size.height * 0.08369565,
              child: Text('Analytics', style: productspageHeaders),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.53125,
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
            left: MediaQuery.of(context).size.width * 0.5703125,
            top: MediaQuery.of(context).size.height * 0.02005348,
            child: IconButton(
              onPressed: () {
                if (selectedProducts.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        icon: Icon(Icons.error, color: Colors.red),
                        content: Text('No products selected.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
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
                }
              },
              icon: Icon(Icons.remove_circle,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.03125),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.4921875,
            top: MediaQuery.of(context).size.height * 0.02005348,
            child: IconButton(
              onPressed: () {
                if (selectedProducts.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        icon: Icon(Icons.error, color: Colors.red),
                        content: Text('No products selected.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: SizedBox(
                                width: 400,
                                height: 200,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 20,
                                      top: 20,
                                      child: SizedBox(
                                          width: 150,
                                          height: 30,
                                          child: Text('Update Quantity',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Hind Kochi'))),
                                    ),
                                    Positioned(
                                        top: 50,
                                        left: 20,
                                        child: Text(
                                          "Updating quantity of: $selectedProducts",
                                        )),
                                    Positioned(
                                      left: 20,
                                      top: 70,
                                      child: SizedBox(
                                        width: 350,
                                        height: 60,
                                        child: TextField(
                                          controller: newquantityController,
                                          decoration: InputDecoration(
                                            labelText: 'New Quantity',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 150,
                                      left: 130,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              for (String product
                                                  in selectedProducts) {
                                                updateQuantity(
                                                    productMap[product]!,
                                                    newquantityController.text);
                                              }
                                              selectedProducts = [];
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Update'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )));
                      });
                }
              },
              icon: Icon(Icons.swap_vert_circle,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.03125),
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
                      child: Text(
                        products[index],
                        style: productsGrid,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1671123,
            left: MediaQuery.of(context).size.width * 0.6484375,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3125,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3125,
                      height: MediaQuery.of(context).size.height * 0.40106952,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return FlLine(
                                color: Colors.white,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              getTextStyles: (context, value) => const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 2:
                                    return 'APR';
                                  case 5:
                                    return 'JUN';
                                  case 8:
                                    return 'SEP';
                                }
                                return '';
                              },
                              margin: 8,
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) => const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 1:
                                    return '10k';
                                  case 3:
                                    return '30k';
                                  case 5:
                                    return '50k';
                                }
                                return '';
                              },
                              reservedSize: 28,
                              margin: 12,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          minX: 0,
                          maxX: 11,
                          minY: 0,
                          maxY: 6,
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 3),
                                FlSpot(2.6, 2),
                                FlSpot(4.9, 5),
                                FlSpot(6.8, 3.1),
                                FlSpot(8, 4),
                                FlSpot(9.5, 3),
                                FlSpot(11, 4),
                              ],
                              isCurved: true,
                              colors: gradientColors,
                              barWidth: 5,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: false,
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.3))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: getMostSoldProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3125,
                          height: MediaQuery.of(context).size.height * 0.40106952,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('Product Name'),
                              ),
                              DataColumn(
                                label: Text('Times Sold'),
                              ),
                            ],
                            rows: snapshot.data?.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(data['Name'])),
                                  DataCell(Text(data['Times Sold'].toString())),
                                ],
                              );
                            }).toList() ?? [],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
