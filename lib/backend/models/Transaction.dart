import 'package:hexpay/backend/models/Arguments.dart';
import 'package:hexpay/backend/models/Date.dart';
import 'package:hexpay/backend/models/User.dart';

class Transaction {
  User by;
  User to;
  int amount;
  Date dateTime;
  Transaction.fromJson(Map<String, dynamic> json) {
    by = User(
      upiId: json['by']['upi_id'],
      phone: json['by']['phone'],
    );
    to = User(
      upiId: json['to']['upi_id'],
      phone: json['to']['phone'],
    );
    amount = json['amount'];
    dateTime = Date(json['time']);
  }
}

class TransactionArguments implements Arguments {
  String toName;
  String toUpiId;
  int amount;
  String fromPhone;
  TransactionArguments(this.toName, this.toUpiId,
      {this.amount, this.fromPhone});
}
