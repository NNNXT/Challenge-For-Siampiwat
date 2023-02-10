// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Internal Modules
import 'package:challenge/constat.dart';
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/model/product/product.dart';

class ListProduct extends StatelessWidget {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;
  final List<ProductData> listProduct;
  final Function(int productId) onTapProduct;
  final Function(int productId) onTapSaved;

  const ListProduct({
    required this.listProduct,
    required this.onTapProduct,
    required this.onTapSaved,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  Widget _product({
    required ProductData data,
    required int index,
  }) {
    var isSaved = data.isSaved;
    var productId = data.id;
    return GestureDetector(
      onTap: () => onTapProduct(productId),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [kBoxShadow()],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: data.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Icon(
                        isSaved
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: isSaved ? Colors.red : Colors.grey,
                      ),
                      onTap: () => onTapSaved(productId),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text((data.price ?? 0).toCurrency())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: padding,
        child: StaggeredGrid.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          children: List.generate(
            listProduct.length,
            (index) => _product(
              index: index,
              data: listProduct[index],
            ),
          ),
        ),
      );
}
