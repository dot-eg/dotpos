import '../cloudbase/product_retrieve.dart';

class SearchService {
  List<String> _products = products;

  SearchService(this._products);

  List<String> search(String searchText) {
    List<String> searchResults = [];
    if (searchText != "") {
      for (var product in _products) {
        if (product.toLowerCase().contains(searchText.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
    return searchResults;
  }
}