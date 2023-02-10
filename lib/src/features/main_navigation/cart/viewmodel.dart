// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/model/cart/cart.dart';
import 'package:challenge/src/provider/cart_provider.dart';

class CartViewmodel extends ChangeNotifier {
  final CartProvider _cartProvider;

  List<CartData> get _listCartData => _cartProvider.listCartData;

  List<CartData> get listCartData => _listCartData;

  void removeCartData({
    required CartData cartData,
  }) {
    _cartProvider.removeCartData(cartData: cartData);
  }

  void decreaseQuantity({required int index}) {
    _listCartData[index].quantity--;
    notifyListeners();
  }

  void increaseQuantity({required int index}) {
    _listCartData[index].quantity++;
    notifyListeners();
  }

  CartViewmodel({
    required BuildContext context,
  }) : _cartProvider = context.provide();
}
