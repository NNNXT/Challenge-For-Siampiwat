// External Modules
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(createToJson: false)
class ProductData {
  @JsonKey(name: 'id', defaultValue: -1)
  int id;

  String? name;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  num? price;

  bool isSaved;

  ProductData({
    required this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.isSaved = false,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
}
