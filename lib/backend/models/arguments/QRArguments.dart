import 'package:hexpay/backend/models/arguments/Arguments.dart';

class QRArguments implements Arguments {
  String transactionId;
  QRArguments(this.transactionId);
}
