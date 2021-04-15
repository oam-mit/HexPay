import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexpay/backend/models/User.dart';

class StorageView {
  final storage = new FlutterSecureStorage();

  Future<void> storeUser(User user) async {
    await storage.write(key: 'user', value: jsonEncode(user));
  }

  Future<String> getUser() async {
    Map userDetails = await storage.readAll();
    return userDetails['user'];
  }

  Future<Map> deleteUser() async {
    try {
      await storage.delete(key: 'user');
      return {'status': 'successful'};
    } catch (e) {
      return {'status': 'unsuccessful'};
    }
  }
}
