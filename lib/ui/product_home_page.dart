import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../services/notification_service.dart';
import 'text_styles.dart';
import '../services/search_service.dart';
import 'product_page.dart';
import 'checkout_page.dart';

class ProductHomePage extends StatefulWidget {
  @override
  _ProductHomePageState createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  NotificationService _notificationService = NotificationService();
  TextEditingController _searchController = TextEditingController();
  List<String> _products = products;
  List<String> _searchResults = [];
  List<String> poutofstock = outofstock;
  late SearchService _searchService;
  late CartModel cart;
  ValueNotifier<bool> _firstopen = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _searchService = SearchService(_products);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstopen.value) {
      _notificationService.showLowQuantityNotification(context);
      _firstopen.value = false;
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {
      _searchResults = _searchService.search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _searchController.clear();
            _searchResults = [];
          });
        },
        child: Scaffold(
            body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/backgrounds/products_bg.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.66015625,
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.359375,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      BoxDecoration(color: Color(0xB29A9393).withOpacity(0.5)),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.35677083,
                top: MediaQuery.of(context).size.height * 0.02774975,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.27799479,
                    height: MediaQuery.of(context).size.height * 0.07568113,
                    decoration: ShapeDecoration(
                      color: Color(0x66D9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ))),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.02864583,
                top: MediaQuery.of(context).size.height * 0.04667003,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.16015625,
                  height: MediaQuery.of(context).size.height * 0.04793138,
                  child: Text('Your Products',
                      style: productspageHeaders.copyWith(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.01953125)),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.6796875,
                top: MediaQuery.of(context).size.height * 0.04667003,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.16015625,
                  height: MediaQuery.of(context).size.height * 0.04793138,
                  child: Text('Cart',
                      style: productspageHeaders.copyWith(
                          fontSize:
                              MediaQuery.of(context).size.width * 0.01953125)),
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.67708333,
                  top: MediaQuery.of(context).size.height * 0.82618567,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.14388021,
                    height: MediaQuery.of(context).size.height * 0.0580222,
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
                          Icon(Icons.delete_forever, color: Colors.black),
                          SizedBox(width: 10),
                          Text('Clear', style: productpageButtons),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.83658854,
                top: MediaQuery.of(context).size.height * 0.82618567,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14388021,
                  height: MediaQuery.of(context).size.height * 0.0580222,
                  child: ElevatedButton(
                    onPressed: () {
                      CartModel cart =
                          Provider.of<CartModel>(context, listen: false);
                      if (cart.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                  'Your cart is empty. Please add some items before checking out.'),
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
                        openCheckoutPage(context, cart);
                      }
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
                        Icon(Icons.credit_card, color: Colors.black),
                        SizedBox(width: 10),
                        Text('Checkout', style: productpageButtons),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.68359375,
                top: MediaQuery.of(context).size.height * 0.09460141,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.29296875,
                  height: MediaQuery.of(context).size.height * 0.70635721,
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
                                  future: Future.value(
                                      cart.getPrice(itemEntry.key)),
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
                                style: productspageHeaders.copyWith(
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1.0,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                //Products Grid
                left: MediaQuery.of(context).size.width * 0.01953125,
                top: MediaQuery.of(context).size.height * 0.1135217,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.61848958,
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
                        onTap: poutofstock.contains(products[index])
                            ? null
                            : () {
                                Provider.of<CartModel>(context, listen: false)
                                    .add(products[index]);
                              },
                        onLongPress: () {
                          String selected = productMap[products[index]]!;
                          openProductPage(context, selected);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: poutofstock.contains(products[index])
                                ? const Color.fromARGB(96, 107, 106, 106)
                                    .withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            products[index],
                            style: productsGrid,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.35677083,
                  top: MediaQuery.of(context).size.height * 0.1135217,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _searchController.clear();
                        _searchResults = [];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.53859738,
                        width: MediaQuery.of(context).size.width * 0.27799479,
                        child: _searchResults.isEmpty
                            ? Center(child: Text('No results'))
                            : ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      String selected =
                                          productMap[_searchResults[index]]!;
                                      openProductPage(context, selected);
                                    },
                                    child: ListTile(
                                      title: Text(_searchResults[index]),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.03784057,
                left: MediaQuery.of(context).size.width * 0.32552083,
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  color: Colors.white,
                  onPressed: () async {
                    products = [];
                    List<String> Updatedproducts = await retrieveProductName();
                    outofstock = [];
                    poutofstock = await getOutofStock();
                    setState(() {
                      products = Updatedproducts;
                      _searchController.clear();
                      _searchResults = [];
                      outofstock = poutofstock;
                    });
                  },
                ),
              )
            ],
          ),
        )));
  }
}
