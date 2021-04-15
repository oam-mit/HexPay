import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/QRArguments.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QRArguments arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
          child: QrImage(
        data: arguments.transactionId,
        version: QrVersions.auto,
        size: 320,
        gapless: false,
      )),
    );
  }
}
