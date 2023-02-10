// Flutter Modules
import 'package:flutter/material.dart';

// Internal Modules
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/provider/product_provider.dart';
import 'package:challenge/src/model/product/product.dart';

class SavedViewmodel extends ChangeNotifier {
  final ProductProvider _productProvider;

  List<ProductData> get listSavedProduct => _productProvider.listSavedProduct;

  bool onTapSaved({
    required int productId,
  }) {
    var res = _productProvider.onTapSaved(productId: productId);
    return res;
  }

  SavedViewmodel({
    required BuildContext context,
  }) : _productProvider = context.provide();
}
