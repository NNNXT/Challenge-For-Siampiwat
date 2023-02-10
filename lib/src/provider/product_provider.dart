// Flutter Modules
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Internal Modules
import 'package:challenge/src/model/product/product.dart';
import 'package:challenge/src/model/product/product_list_response.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductData> _listProduct = [];

  List<ProductData> get listProduct => _listProduct;
  List<ProductData> get listSavedProduct =>
      _listProduct.where((element) => element.isSaved).toList();

  bool onTapSaved({
    required int productId,
  }) {
    var index = _listProduct.indexWhere((element) => element.id == productId);
    _listProduct[index].isSaved = !_listProduct[index].isSaved;
    notifyListeners();
    return _listProduct[index].isSaved;
  }

  Future<void> fetchProductList() async {
    var res = await rootBundle.loadString('lib/mock/data.json');
    var data = await json.decode(res);
    _listProduct = ProductListResponse.fromJson(data).result ?? [];
    notifyListeners();
  }
}
