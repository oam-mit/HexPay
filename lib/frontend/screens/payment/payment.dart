import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexpay/backend/models/Transaction.dart';
import 'package:hexpay/backend/views/authview.dart';

import 'package:hexpay/backend/views/paymentView.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';

import 'package:hexpay/locator.dart';
import 'package:hexpay/services/dialogService.dart';

import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  AuthView authView;
  Widget renderBody(TransactionArguments arguments, PaymentView paymentView) {
    if (paymentView.loading)
      return Center(
        child: SpinnerWidget(),
      );
    return Scaffold(
        appBar: AppBar(
          title: Text('Make Payment'),
          elevation: 0,
          backgroundColor: HexColor('#0f1951'),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Container(
            child: Column(
              children: [
                Text(
                  arguments.toName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.length == 0 || int.parse(value) == 0) {
                              return "Please enter amount >0";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                          ),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              arguments.amount =
                                  int.parse(_amountController.text);

                              paymentView.initiateTransaction(arguments);
                            }
                          },
                          icon: Icon(Icons.send_sharp),
                          label: Text('Pay Now'),
                        ),
                        authView.user.isCustomer
                            ? ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    getIt<DialogService>().showYesNoDialog(
                                        'Confimation',
                                        'Are you sure you want to proceed?',
                                        () {
                                      arguments.amount =
                                          int.parse(_amountController.text);

                                      paymentView.placeCredit(arguments);
                                    });
                                  }
                                },
                                icon: Icon(Icons.send_sharp),
                                label: Text('Request Credit'),
                              )
                            : Container(),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TransactionArguments arguments = ModalRoute.of(context).settings.arguments;
    authView = Provider.of<AuthView>(context);
    return ChangeNotifierProvider<PaymentView>.value(
        value: getIt<PaymentView>(),
        child: Consumer<PaymentView>(
          builder: (context, paymentView, child) {
            return Scaffold(
              body: renderBody(arguments, paymentView),
            );
          },
        ));
  }
}
