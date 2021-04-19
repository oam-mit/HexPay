import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/Transaction.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:provider/provider.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  TransactionWidget(this.transaction);
  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context, listen: false);
    return Container(
      width: 300,
      height: 200,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: authView.user.upiId == transaction.by.upiId
                  ? Icon(
                      Icons.arrow_downward_outlined,
                      size: 60,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.arrow_downward_outlined,
                      size: 60,
                      color: Colors.green,
                    ),
              title: authView.user.upiId == transaction.by.upiId
                  ? Text('Sent to', style: TextStyle(fontSize: 30.0))
                  : Text('Received from', style: TextStyle(fontSize: 30.0)),
              subtitle: authView.user.upiId == transaction.by.upiId
                  ? Text(" ${transaction.to.upiId}",
                      style: TextStyle(fontSize: 18.0))
                  : Text(" ${transaction.by.upiId}",
                      style: TextStyle(fontSize: 18.0)),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(transaction.dateTime.formattedDate),
                Text(
                  "Rs." + transaction.amount.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: authView.user.upiId == transaction.by.upiId
                          ? Colors.red
                          : Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
