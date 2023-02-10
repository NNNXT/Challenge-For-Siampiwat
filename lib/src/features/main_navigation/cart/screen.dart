// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge/constat.dart';
import 'package:challenge/navigator_route.dart';
import 'package:challenge/src/base/base_widget.dart';
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/features/main_navigation/cart/viewmodel.dart';
import 'package:challenge/src/widget/empty_container.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  Widget _slideRightToDelete() => Container(
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(
            FontAwesomeIcons.trash,
            color: Colors.white,
          ),
        ),
      );

  Widget _totalPrice(
    BuildContext context, {
    required CartViewmodel model,
  }) {
    var productPrice = model.listCartData.map(
      (e) => e.quantity * (e.product.price ?? 0),
    );

    var totalPrice = productPrice.reduce((value, element) => value + element);

    var textStyle = const TextStyle(
      fontSize: 20,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'cart.total'.tr(),
            style: textStyle,
          ),
          Text(
            totalPrice.toCurrency(),
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => context.go(
              NavigatorRoutePath.checkout.goPath,
              extra: totalPrice,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'cart.checkout'.tr(),
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartContainer(
    BuildContext context, {
    required int index,
    required CartViewmodel model,
  }) {
    var width = context.media.size.width;
    var imageWidth = width * 0.3;
    var textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    var cartData = model.listCartData[index];
    var product = cartData.product;
    var quantity = cartData.quantity;
    var canDecrease = quantity > 1;
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        model.removeCartData(cartData: cartData);
        context.showToast(msg: 'cart.delete_success'.tr());
      },
      key: Key(cartData.product.id.toString()),
      background: _slideRightToDelete(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [kBoxShadow()],
        ),
        child: Row(
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl ?? '',
                width: imageWidth,
                height: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (product.price ?? 0).toCurrency(),
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: canDecrease
                              ? () {
                                  model.decreaseQuantity(index: index);
                                }
                              : null,
                          child: Icon(
                            FontAwesomeIcons.minus,
                            color: canDecrease ? Colors.black : Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            width: width * 0.1,
                            child: Text(
                              quantity.toString(),
                              style: textStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(FontAwesomeIcons.plus),
                          onTap: () {
                            model.increaseQuantity(index: index);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainContainer(
    BuildContext context, {
    required CartViewmodel model,
  }) {
    var listCartData = model.listCartData;
    return listCartData.isEmpty
        ? EmptyContainer(
            icon: FontAwesomeIcons.cartShopping,
            msg: 'cart.empty'.tr(),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, index) => _cartContainer(
                    context,
                    index: index,
                    model: model,
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemCount: listCartData.length,
                ),
              ),
              _totalPrice(
                context,
                model: model,
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) => BaseWidget<CartViewmodel>(
        model: CartViewmodel(context: context),
        builder: (_, model, __) => _mainContainer(
          context,
          model: model,
        ),
      );
}
