// Internal Modules
import 'package:challenge/src/model/product/product.dart';

class ProductListResponse {
  final List<ProductData>? result;

  ProductListResponse({this.result});

  factory ProductListResponse.fromJson(json) => ProductListResponse(
        result: List<Map<String, dynamic>>.from(json['product_items'] as List)
            .map((json) => ProductData.fromJson(json))
            .toList(),
      );
}
