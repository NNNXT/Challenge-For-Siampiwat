// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/model/product/product.dart';
import 'package:challenge/src/provider/cart_provider.dart';
import 'package:challenge/src/provider/product_provider.dart';

class ProductDetailViewmodel extends ChangeNotifier {
  final CartProvider _cartProvider;
  final ProductProvider _productProvider;

  bool onTapSaved({
    required int productId,
  }) {
    var res = _productProvider.onTapSaved(productId: productId);
    return res;
  }

  bool addCartData({
    required ProductData productData,
  }) {
    var res = _cartProvider.addCartData(productData: productData);
    return res;
  }

  ProductDetailViewmodel({
    required BuildContext context,
  })  : _cartProvider = context.provide(),
        _productProvider = context.provide();
}
