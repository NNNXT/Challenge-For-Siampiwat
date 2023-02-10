// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      price: json['price'] as num?,
      isSaved: json['isSaved'] as bool? ?? false,
    );
