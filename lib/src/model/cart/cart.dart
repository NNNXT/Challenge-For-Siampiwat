// External Modules
import 'package:json_annotation/json_annotation.dart';

// Internal Modules
import 'package:challenge/src/model/product/product.dart';

part 'cart.g.dart';

@JsonSerializable(createToJson: false)
class CartData {
  ProductData product;

  int quantity;

  CartData({
    required this.product,
    this.quantity = 1,
  });

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);
}
