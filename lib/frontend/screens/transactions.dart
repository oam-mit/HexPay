import 'package:flutter/material.dart';
import 'package:hexpay/backend/views/commonViews.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:hexpay/frontend/widgets/TransactionWidget.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  CommonViews custView;

  Widget renderBody(CommonViews custView) {
    if (custView.loading) {
      return (SpinnerWidget());
    } else {
      return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return (TransactionWidget(custView.transactions[index]));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: custView.transactions.length);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    custView = CommonViews();
    custView.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ChangeNotifierProvider<CommonViews>.value(
        value: custView,
        child: Consumer<CommonViews>(
          builder: (context, custView, child) {
            return Center(child: this.renderBody(custView));
          },
        ),
      ),
    );
  }
}
