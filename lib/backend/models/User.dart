class User {
  String token;
  String phone;
  String email;
  String firstName;
  String lastName;
  String upiId;
  bool isShop;
  bool isCustomer;
  String shopName;

  User(
      {this.phone,
      this.firstName,
      this.lastName,
      this.token,
      this.email,
      this.isCustomer,
      this.isShop,
      this.shopName,
      this.upiId});

  User.fromJson(Map<String, dynamic> mappedResponse) {
    token = mappedResponse['token'];
    phone = mappedResponse['phone'];
    email = mappedResponse['email'];
    firstName = mappedResponse['first_name'];
    lastName = mappedResponse['last_name'];
    upiId = mappedResponse['upi_id'];
    isShop = mappedResponse['is_shop'];
    isCustomer = mappedResponse['is_customer'];
    shopName = mappedResponse['shop_name'];
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'phone': phone,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'upiId': upiId,
        'is_shop': isShop,
        'is_customer': isCustomer,
        'shop_name': 'shop_name',
      };
}
