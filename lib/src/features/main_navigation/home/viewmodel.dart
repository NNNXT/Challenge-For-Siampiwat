// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/provider/product_provider.dart';
import 'package:challenge/src/model/product/product.dart';

class HomeViewmodel extends ChangeNotifier {
  final ProductProvider _productProvider;

  List<ProductData> get _listProduct => _productProvider.listProduct;

  List<ProductData> get listProduct => _listProduct;

  bool onTapSaved({
    required int productId,
  }) {
    var res = _productProvider.onTapSaved(productId: productId);
    return res;
  }

  HomeViewmodel({
    required BuildContext context,
  }) : _productProvider = context.provide();
}
