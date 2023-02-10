// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Internal Modules
import 'package:challenge/src/base/base_widget.dart';
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/features/product/detail/viewmodel.dart';
import 'package:challenge/src/model/product/product.dart';

class ProductDetail extends StatelessWidget {
  final ProductData product;

  const ProductDetail({
    required this.product,
    super.key,
  });

  Widget _mainContainer(
    BuildContext context, {
    required ProductDetailViewmodel model,
  }) {
    var isSaved = product.isSaved;
    var width = context.media.size.width;
    var padding = 16.0;
    var iconSize = 24.0;
    var textWidth = width - ((padding * 2) + iconSize);
    var textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: textWidth,
                  child: Text(
                    product.name ?? '',
                    style: textStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  child: Icon(
                    isSaved
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: isSaved ? Colors.red : Colors.grey,
                  ),
                  onTap: () {
                    var res = model.onTapSaved(productId: product.id);
                    if (res) {
                      context.showToast(msg: 'saved.add_product'.tr());
                    } else {
                      context.showToast(msg: 'saved.remove_product'.tr());
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              (product.price ?? 0).toCurrency(),
              style: textStyle,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                var res = model.addCartData(productData: product);
                if (res) {
                  context.showToast(
                    msg: 'product_detail.add_cart_complete'.tr(),
                  );
                } else {
                  context.showToast(
                    msg: 'product_detail.add_cart_error'.tr(),
                  );
                }
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'product_detail.add_to_cart'.tr(),
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BaseWidget<ProductDetailViewmodel>(
        model: ProductDetailViewmodel(context: context),
        builder: (_, model, __) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: _mainContainer(
            context,
            model: model,
          ),
        ),
      );
}
