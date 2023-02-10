// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Internal Modules
import 'package:challenge/src/base/base_widget.dart';
import 'package:challenge/src/features/main_navigation/cart/screen.dart';
import 'package:challenge/src/features/main_navigation/home/screen.dart';
import 'package:challenge/src/features/main_navigation/saved/screen.dart';
import 'package:challenge/src/features/main_navigation/viewmodel.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseWidget<MainNavigationViewmodel>(
        model: MainNavigationViewmodel(context: context),
        onModelReady: (model) async {
          await model.fetchProductList();
        },
        builder: (_, model, __) {
          var selectedIndex = model.selectedIndex;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                model.title[selectedIndex].tr(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
            body: IndexedStack(
              index: selectedIndex,
              children: const [
                HomeScreen(),
                SavedScreen(),
                CartScreen(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.house),
                  label: 'main.home'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.heart),
                  label: 'main.saved'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(FontAwesomeIcons.cartShopping),
                      Visibility(
                        visible: model.showCountCart,
                        child: Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(model.cartProductLength.toString()),
                        ),
                      )
                    ],
                  ),
                  label: 'main.cart'.tr(),
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: (value) {
                model.selectIndex(value);
              },
            ),
          );
        },
      );
}
