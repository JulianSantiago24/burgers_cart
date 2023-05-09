

import 'package:flutter/material.dart';
import 'package:flutter_app_burguers/burgers_products.dart';

enum BurgersState {
  normal,
  details,
  cart
}

class BurgerStoreBloC with ChangeNotifier {

  BurgersState burgersState = BurgersState.normal;
  List<BurgersProduct> catalog = List.unmodifiable(burgersProducts);
  List<BurgersProductItem> cart = [];


  void changeToNormal() {
    burgersState = BurgersState.normal;
    notifyListeners();
  }

  void changeToCart() {
    burgersState = BurgersState.cart;
    notifyListeners();
  }

  void alert(BuildContext context) {
    
  }

  dynamic addProduct(BurgersProduct product, BuildContext context) {
    for (BurgersProductItem item in cart) {
      if (item.product.name == product.name) {
        return print('Could not '); // TODO Message Error
      }
    }
    cart.add(BurgersProductItem(quantity: 1, product: product));
    notifyListeners();
  }

  int totalProducts() => cart.fold<int>(0, (previousValue, element) => previousValue + element.quantity);

  double totalPriceProducts() => cart.fold<double>(0, (previousValue, element) => previousValue + (element.quantity * element.product.price));

  String discountPriceProducts() {
    // TODO Rules
    if (cart.length == 3) {
      return "20%";
    } else if (cart.length == 2) {
      return "15%";
    }    
    return "No Aplica";
  }
}

class BurgersProductItem {
  BurgersProductItem({required this.quantity, required this.product});
  int quantity;
  final BurgersProduct product;

  void increment() {

  }

  void decrement() {

  }

}