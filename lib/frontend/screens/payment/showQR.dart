import 'package:flutter/material.dart';

class QRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: Text('QR Code will be visible here'),
      ),
    );
  }
}
