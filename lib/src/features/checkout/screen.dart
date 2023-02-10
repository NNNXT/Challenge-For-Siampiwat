// Flutter Modules
import 'package:flutter/material.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Internal Modules
import 'package:challenge/src/base/basic_extension.dart';

class Checkout extends StatelessWidget {
  final num totalPrice;

  const Checkout({
    required this.totalPrice,
    super.key,
  });

  Widget _mainContainer(BuildContext context) {
    var qrCodePath =
        'https://payment.spw.challenge/checkout?price=${totalPrice.toString()}';

    var textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 8),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: QrImage(
              data: qrCodePath,
              version: QrVersions.auto,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'checkout.payment'.tr(),
            style: textStyle,
          ),
          const SizedBox(height: 24),
          Text(
            totalPrice.toCurrency(),
            style: textStyle.copyWith(fontSize: 20),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleSpacing: 0,
          title: Text(
            'checkout.title'.tr(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: _mainContainer(
          context,
        ),
      );
}
