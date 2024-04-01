import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  void add(String item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(String item) {
    _items.remove(item);
    notifyListeners();
  }
  void clear() {
    _items.clear();
    notifyListeners();
  }
}