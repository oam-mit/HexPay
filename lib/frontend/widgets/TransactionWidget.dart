import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/Transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  TransactionWidget(this.transaction);
  @override
  Widget build(BuildContext context) {
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
              leading: Icon(Icons.money_outlined, size: 60),
              title: Text('Received From', style: TextStyle(fontSize: 30.0)),
              subtitle: Text(" ${transaction.by.upiId}",
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
                      fontWeight: FontWeight.bold, color: Colors.brown),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
