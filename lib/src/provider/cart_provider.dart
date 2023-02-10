// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge/src/model/cart/cart.dart';
import 'package:challenge/src/model/product/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartData> _listCartData = [];

  List<CartData> get listCartData => _listCartData;

  bool addCartData({
    required ProductData productData,
  }) {
    var checkDuplicateCart = listCartData
        .where((element) => element.product.id == productData.id)
        .toList();
    if (checkDuplicateCart.isEmpty) {
      _listCartData.add(
        CartData(product: productData),
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeCartData({
    required CartData cartData,
  }) {
    _listCartData.removeWhere((element) => element == cartData);
    notifyListeners();
  }
}
