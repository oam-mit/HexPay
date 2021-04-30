import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/backend/views/commonViews.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:hexpay/frontend/widgets/TransactionWidget.dart';
import 'package:provider/provider.dart';

class ShopHomeScreen extends StatefulWidget {
  @override
  _ShopHomeScreenState createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  CommonViews custView;

  Widget renderBody(CommonViews custView) {
    if (custView.loading) {
      return (SpinnerWidget());
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          custView.getTransactions();
        },
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return (TransactionWidget(custView.transactions[index]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: custView.transactions.length),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    custView = CommonViews();
    custView.getTransactions();
  }

  Widget _renderDrawer(context, AuthView authView) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Text(
                  authView.user.firstName + " " + authView.user.lastName,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    authView.logout();
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: HexColor('#0f1951'),
            ),
          ),
          ListTile(
            title: Text('Analytics'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: HexColor('#0f1951'),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.camera_enhance_outlined),
              onPressed: () {
                custView.scanQRCode();
              })
        ],
      ),
      drawer: _renderDrawer(context, authView),
      body: ChangeNotifierProvider<CommonViews>.value(
        value: custView,
        child: Consumer<CommonViews>(
          builder: (context, custView, child) {
            return Stack(children: [
              Image.asset('assets/images/background.png'),
              Center(child: this.renderBody(custView))
            ]);
          },
        ),
      ),
    );
  }
}
