import 'package:cart_app/data/products.data.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  List searchList = [...productList];
  

  String _dropdownValue = 'default';

  get dropdownValue => _dropdownValue;
  set dropdownValue(value) {
    _dropdownValue = value;
    notifyListeners();
  }

  sortAsc() {
    searchList.sort(
      (a, b) => a.p_price.compareTo(b.p_price),
    );
    notifyListeners();
  }

  sortDesc() {
    searchList.sort(
      (a, b) => b.p_price.compareTo(a.p_price),
    );
    notifyListeners();
  }

  sortDefault() {
    searchList.sort(
      (a, b) => a.p_id.compareTo(b.p_id),
    );
    notifyListeners();
  }

  search(value) {
    if (productList.any((element) =>
        element.p_name.toLowerCase().contains(value.toLowerCase()))) {
      searchList = productList
          .where((element) =>
              element.p_name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      searchList = [];
    }
    notifyListeners();
  }
}
