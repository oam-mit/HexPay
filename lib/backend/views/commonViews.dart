import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/Transaction.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/urls.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/dialogService.dart';
import 'package:http/http.dart';
import 'package:barcode_scan/barcode_scan.dart';

class CommonViews extends ChangeNotifier {
  bool _loading = false;

  List<Transaction> _transactions = [];

  bool get loading => _loading;
  List<Transaction> get transactions => _transactions;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void getTransactions() async {
    Uri url = Uri.parse(BASE_URL + "/api/transactions/get_transactions");
    AuthView authview = getIt<AuthView>();

    setLoading(true);
    try {
      Response resp =
          await get(url, headers: {'Authorization': authview.token});

      Map mappedResponse = jsonDecode(resp.body);
      _transactions = [];

      for (var transaction in mappedResponse['transactions']) {
        _transactions.add(Transaction.fromJson(transaction));
      }
    } catch (e) {
      print(e);
      getIt<DialogService>()
          .showAlertDialog('Error', 'Please check your network connection');
    }
    setLoading(false);
  }

  void scanQRCode() async {
    ScanResult codeSanner = await BarcodeScanner.scan(
      options: ScanOptions(
        useCamera: -1,
      ),
    );

    getIt<DialogService>().showAlertDialog('Alert',
        'Transaction Id is: ${codeSanner.rawContent}. Validation left');
  }
}
