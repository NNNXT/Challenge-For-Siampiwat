// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge/navigator_route.dart';
import 'package:challenge/src/base/base_widget.dart';
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/features/main_navigation/home/viewmodel.dart';
import 'package:challenge/src/features/product/widget/list_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseWidget<HomeViewmodel>(
        model: HomeViewmodel(context: context),
        builder: (_, model, __) => ListProduct(
          listProduct: model.listProduct,
          onTapSaved: (productId) {
            var res = model.onTapSaved(productId: productId);
            if (res) {
              context.showToast(msg: 'saved.add_product'.tr());
            } else {
              context.showToast(msg: 'saved.remove_product'.tr());
            }
          },
          onTapProduct: (productId) {
            var product = model.listProduct.singleWhere(
              (element) => element.id == productId,
            );
            context.go(
              NavigatorRoutePath.productDetail.goPath,
              extra: product,
            );
          },
        ),
      );
}
