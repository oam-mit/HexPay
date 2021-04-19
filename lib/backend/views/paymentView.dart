import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/arguments/QRArguments.dart';
import 'package:hexpay/backend/models/Transaction.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/consts/urls.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:http/http.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentView extends ChangeNotifier {
  Razorpay _razorpay;

  bool _loading = false;
  bool get loading => _loading;

  TransactionArguments _arguments;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  PaymentView.initialize() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Uri url = Uri.parse(BASE_URL + "/api/transactions/make_transaction");
    Response resp = await post(url,
        body: jsonEncode({
          'to': _arguments.toUpiId,
          'amount': _arguments.amount.toString(),
          'transaction_id': response.paymentId
        }),
        headers: {
          'Authorization': getIt<AuthView>().token,
          "content-type": "application/json"
        });
    print(resp.body);
    getIt<NavigationService>()
        .replaceTo(QR_CODE, arguments: QRArguments(response.paymentId));
    setLoading(false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response);
    setLoading(false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
  }

  void initiateTransaction(TransactionArguments arguments) {
    _arguments = arguments;
    var options = {
      'key': 'rzp_test_UzXYQPXnbQesB8',
      'amount': arguments.amount * 100,
      'name': arguments.toName,
      'description': 'Payment via HexPay',
      'prefill': {
        'contact': '+91' + arguments.fromPhone,
      }
    };

    setLoading(true);

    _razorpay.open(options);
  }
}
