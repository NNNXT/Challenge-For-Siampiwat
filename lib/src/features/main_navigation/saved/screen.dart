// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge/navigator_route.dart';
import 'package:challenge/src/base/base_widget.dart';
import 'package:challenge/src/base/basic_extension.dart';
import 'package:challenge/src/features/main_navigation/saved/viewmodel.dart';
import 'package:challenge/src/features/product/widget/list_product.dart';
import 'package:challenge/src/widget/empty_container.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseWidget<SavedViewmodel>(
        model: SavedViewmodel(context: context),
        builder: (_, model, __) {
          var listSavedProduct = model.listSavedProduct;
          return listSavedProduct.isEmpty
              ? EmptyContainer(
                  icon: FontAwesomeIcons.heartCrack,
                  msg: 'saved.empty'.tr(),
                )
              : ListProduct(
                  listProduct: listSavedProduct,
                  onTapSaved: (productId) {
                    var res = model.onTapSaved(productId: productId);
                    if (res) {
                      context.showToast(msg: 'saved.add_product'.tr());
                    } else {
                      context.showToast(msg: 'saved.remove_product'.tr());
                    }
                  },
                  onTapProduct: (productId) {
                    var product = model.listSavedProduct.singleWhere(
                      (element) => element.id == productId,
                    );
                    context.go(
                      NavigatorRoutePath.productDetail.goPath,
                      extra: product,
                    );
                  },
                );
        },
      );
}
