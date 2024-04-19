import 'package:flutter/foundation.dart';
import 'firestore_service.dart';

class CartModel extends ChangeNotifier {
  Map<String, int> _items = {};
  Map<String, double> _prices = {};

  Map<String, int> get items => _items;

  void add(String item) async {
    if (_items.containsKey(item)) {
      _items[item] = (_items[item] ?? 0) + 1;
    } else {
      _items[item] = 1;
      if (!_prices.containsKey(item)) {
        var productData = await retrieveProductData(productMap[item]!);
        _prices[item] = productData['Price'] != null ? productData['Price'].toDouble() : 0.0;
      }
    }
    notifyListeners();
  }

  void remove(String item) {
    if (_items.containsKey(item)) {
      _items[item] = (_items[item] ?? 0) - 1;
      if (_items[item]! <= 0) {
        _items.remove(item);
      }
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _prices.clear();
    notifyListeners();
  }

  double getPrice(String item) {
    return _prices[item] ?? 0.0;
  }

  double getTotal() {
    double total = 0.0;
    _items.forEach((key, value) {
      total += (_prices[key] ?? 0.0) * value;
    });
    return total;
  }

  bool get isEmpty => _items.isEmpty;
}