// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:provider/provider.dart';

// Internal Modules
import 'package:challenge/navigator_route.dart';
import 'package:challenge/src/provider/cart_provider.dart';
import 'package:challenge/src/provider/product_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<CartProvider>(
            create: (_) => CartProvider(),
          ),
          ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider(),
          ),
        ],
        child: materialApp(context),
      );
}
