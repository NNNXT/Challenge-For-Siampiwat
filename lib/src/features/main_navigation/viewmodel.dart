// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/provider/cart_provider.dart';
import 'package:challenge/src/provider/product_provider.dart';

class MainNavigationViewmodel extends ChangeNotifier {
  final CartProvider _cartProvider;
  final ProductProvider _productProvider;

  int _selectedIndex = 0;

  final List<String> _title = [
    'main.home_title',
    'main.saved',
    'main.cart',
  ];

  bool get showCountCart => cartProductLength > 0;

  int get selectedIndex => _selectedIndex;

  int get cartProductLength => _cartProvider.listCartData.length;

  List<String> get title => _title;

  void selectIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> fetchProductList() async {
    await _productProvider.fetchProductList();
  }

  MainNavigationViewmodel({
    required BuildContext context,
  })  : _cartProvider = context.provide(),
        _productProvider = context.provide();
}
