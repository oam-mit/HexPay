import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/Shop.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/urls.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/dialogService.dart';
import 'package:http/http.dart';

class CustomerView with ChangeNotifier {
  bool _loading = false;
  List<Shop> _shops = [];

  void _setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;
  List<Shop> get shops => _shops;

  void fetchShops() async {
    Uri url = Uri.parse(BASE_URL + "/api/user/get_shops");
    _setLoading(true);
    try {
      Response resp = await get(url);
      Map mappedResponse = jsonDecode(resp.body);

      //print(mappedResponse);
      for (var shop in mappedResponse['shops']) {
        _shops.add(Shop.fromJson(shop));
      }
      _setLoading(false);
    } catch (e) {
      getIt<DialogService>()
          .showAlertDialog('Error', 'Please check your network');
    }
  }

  CustomerView();

  CustomerView.initialize() {
    fetchShops();
  }

  void getCredits() async {
    Uri url =
        Uri.parse(BASE_URL + "/api/transactions/credit/get_credit_customer");
    _setLoading(true);

    try {
      Response resp =
          await get(url, headers: {'Authorization': getIt<AuthView>().token});
      Map mappedResponse = jsonDecode(resp.body);
      print(mappedResponse);
      //_setLoading(false);
    } catch (e) {
      getIt<DialogService>()
          .showAlertDialog('Error', 'Please check your network');
    }
  }
}
