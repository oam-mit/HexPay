import 'package:hexpay/backend/models/User.dart';

class Shop extends User {
  String city;
  String pinCode;
  String landmark;
  String typeOfBusiness;
  Shop.fromJson(Map<String, dynamic> shop) {
    this.phone = shop['phone'];
    this.upiId = shop['upi_id'];
    this.firstName = shop['first_name'];
    this.shopName = shop['shop']['shop_name'];
    this.city = shop['shop']['city'];
    this.pinCode = shop['shop']['pin_code'];
    this.landmark = shop['shop']['landmark'];
    this.typeOfBusiness = shop['shop']['type_of_business'];
  }
}
