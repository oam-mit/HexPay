import 'package:hexpay/backend/models/Arguments.dart';

class QRArguments implements Arguments {
  String transactionId;
  QRArguments(this.transactionId);
}
