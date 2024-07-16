import 'package:cart_app/data/products.data.dart';
import 'package:cart_app/models/cart.model.dart';
import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  List cartList = [];

  addToCart(index) {
    var currItem = searchList[index];
    bool found = false;

    for (int i = 0; i < cartList.length; i++) {
      if (cartList[i].productId == currItem.p_id) {
        cartList[i].productQuantity += 1;
        cartList[i].productAmount += currItem.p_price;
        found = true;
        break;
      }
    }

    if (!found) {
      cartList.add(Cart(
        productId: currItem.p_id,
        productName: currItem.p_name,
        productAmount: currItem.p_price,
        productImage: currItem.p_image,
      ));
    }

    notifyListeners();
  }

  removeFromCart(index) {
    cartList.removeAt(index);
    notifyListeners();
  }

  increaseQuantity(index) {
    var unitPrice =
        cartList[index].productAmount / cartList[index].productQuantity;
    cartList[index].productQuantity += 1;
    cartList[index].productAmount += unitPrice;
    notifyListeners();
  }

  decreaseQuantity(index) {
    var unitPrice =
        cartList[index].productAmount / cartList[index].productQuantity;
    if (cartList[index].productQuantity == 1) {
      removeFromCart(index);
    } else {
      cartList[index].productQuantity -= 1;
      cartList[index].productAmount -= unitPrice;
    }
    notifyListeners();
  }
}
