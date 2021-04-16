import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:hexpay/backend/models/User.dart';
import 'package:hexpay/backend/views/storageView.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/consts/urls.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/dialogService.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:http/http.dart';

class AuthView extends ChangeNotifier {
  bool _loading = false;
  bool _isAuthenticated;
  User _user;

  bool get loading => _loading;
  bool get isAuthenticated => _isAuthenticated;
  User get user => _user;

  String get token => "Token " + _user.token;

  StorageView storage = getIt<StorageView>();

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void checkLoggedIn() async {
    setLoading(true);
    String user = await storage.getUser();
    if (user == null) {
      //print('not logged in'); //TODO :Remove
      setAuthenticated(false);
      getIt<NavigationService>().replaceTo(LOGIN);
    } else {
      this._user = User.fromJson(jsonDecode(user));
      setAuthenticated(true);
      getIt<NavigationService>().replaceTo(HOME);
    }
    setLoading(false);
  }

  AuthView.checkLoggedIn() {
    checkLoggedIn();
  }

  void login(phone, password) async {
    if (phone.length == 0 || password.length == 0) {
      getIt<DialogService>().showAlertDialog(
          'Error', 'Please enter both phone number and password');
      return;
    }
    Uri url = Uri.parse(BASE_URL + "/api/user/login");
    setLoading(true);
    Response resp =
        await post(url, body: {'username': phone, 'password': password});

    Map mappedResponse = jsonDecode(resp.body);
    if (mappedResponse['status'] == 'successful') {
      if (mappedResponse['is_customer'] == true) {
        _user = User.fromJson(mappedResponse);

        await storage.storeUser(_user);
        setAuthenticated(true);
        getIt<NavigationService>().replaceTo(HOME);
      } else {
        getIt<DialogService>().showAlertDialog(
            'Success', 'Logged in as shop but shop pages under development');
      }
    } else {
      getIt<DialogService>()
          .showAlertDialog('Error', 'Please check username and password');
    }

    setLoading(false);
  }

  void registerShop(Map<String, dynamic> details) async {
    setLoading(true);
    try {
      dio.FormData formData = dio.FormData.fromMap(details);

      dio.Dio _dio = dio.Dio();
      dio.Response response =
          await _dio.post(BASE_URL + "/api/user/register_shop", data: formData);

      Map data = response.data;
      if (data['status'] == 'successful') {
        getIt<NavigationService>().pop();
        getIt<DialogService>().showAlertDialog(
            'Success', 'Your data has been registered successfully');
      } else {
        if (data['errors']['phone'] != null) {
          getIt<DialogService>()
              .showAlertDialog('Error', 'Your phone is already registered');
        } else if (data['errors']['upi_id'] != null) {
          getIt<DialogService>()
              .showAlertDialog('Error', 'Your UPI ID is already registered');
        } else {
          getIt<DialogService>()
              .showAlertDialog('Error', 'Please check all your inputs');
        }
      }
    } catch (e) {
      getIt<DialogService>()
          .showAlertDialog('Error', 'Please check your internet connection');
    }
    setLoading(false);
  }

  void logout() async {
    Map status = await getIt<StorageView>().deleteUser();
    if (status['status'] == 'successful') {
      getIt<NavigationService>().replaceTo(LOGIN);
      getIt<DialogService>()
          .showAlertDialog('Success', 'Logged out successfully');
    } else {
      getIt<DialogService>().showAlertDialog('Error', 'Please try again');
    }
  }
}
