import 'package:flutter/material.dart';
import 'package:hexpay/backend/views/customerViews.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';

class CustomerCreditScreen extends StatefulWidget {
  @override
  _CustomerCreditScreenState createState() => _CustomerCreditScreenState();
}

class _CustomerCreditScreenState extends State<CustomerCreditScreen> {
  CustomerView customerView;

  @override
  void initState() {
    // TODO: implement initState
    customerView = CustomerView();
    customerView.getCredits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits taken'),
      ),
      body: SpinnerWidget(),
    );
  }
}
