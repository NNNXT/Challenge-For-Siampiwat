// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

// Internal Modules
import 'package:challenge/src/model/product/product.dart';

// Screen
import 'package:challenge/src/features/checkout/screen.dart';
import 'package:challenge/src/features/main_navigation/screen.dart';
import 'package:challenge/src/features/product/detail/screen.dart';

enum NavigatorRoutePath { home, productDetail, checkout }

extension NavigatorRoutePathExtension on NavigatorRoutePath {
  String get path {
    switch (this) {
      case NavigatorRoutePath.home:
        return '/';

      case NavigatorRoutePath.productDetail:
        return 'product/details';

      case NavigatorRoutePath.checkout:
        return 'checkout';

      default:
        return '';
    }
  }

  String get goPath {
    switch (this) {
      case NavigatorRoutePath.productDetail:
        return '/product/details';

      case NavigatorRoutePath.checkout:
        return '/checkout';

      default:
        return '';
    }
  }
}

var _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: NavigatorRoutePath.home.path,
      builder: (_, __) => const MainNavigation(),
      routes: <RouteBase>[
        GoRoute(
          path: NavigatorRoutePath.productDetail.path,
          builder: (_, state) {
            ProductData productData = state.extra as ProductData;
            return ProductDetail(product: productData);
          },
        ),
        GoRoute(
          path: NavigatorRoutePath.checkout.path,
          builder: (_, state) {
            num totalPrice = state.extra as num;
            return Checkout(totalPrice: totalPrice);
          },
        ),
      ],
    ),
  ],
);

MaterialApp materialApp(BuildContext context) => MaterialApp.router(
      title: 'Challange',
      routerConfig: _router,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
