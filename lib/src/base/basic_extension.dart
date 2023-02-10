// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

extension BuildContextProvide on BuildContext {
  T provide<T>({bool listen = true}) => Provider.of<T>(
        this,
        listen: listen,
      );

  MediaQueryData get media => MediaQuery.of(this);

  void showToast({required String msg}) {
    Fluttertoast.showToast(msg: msg);
  }
}

extension DoubleParsing on double {
  String toDecimal({bool withFraction = true}) =>
      toCurrency(withFraction: withFraction, symbol: '');

  String toCurrency({
    bool withFraction = true,
    String symbol = '\$',
  }) {
    var hasFraction = this != roundToDouble();
    var formatter = NumberFormat.currency(
      name: 'THB',
      decimalDigits: (withFraction && hasFraction) ? 2 : 0,
      symbol: symbol,
    );
    return formatter.format(this);
  }
}

extension NumParsing on num {
  String toCurrency({
    bool withFraction = true,
    String symbol = '\$',
  }) =>
      toDouble().toCurrency(
        withFraction: withFraction,
        symbol: symbol,
      );
}
