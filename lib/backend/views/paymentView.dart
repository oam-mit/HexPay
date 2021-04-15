import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/QRArguments.dart';
import 'package:hexpay/backend/models/Transaction.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentView extends ChangeNotifier {
  Razorpay _razorpay;

  bool _loading = true;
  bool get loading => _loading;

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
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
