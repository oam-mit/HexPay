import 'package:flutter/material.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/backend/views/customerViews.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/frontend/widgets/ShopWidget.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  Widget _renderDrawer(context, AuthView authView) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Text(
                  authView.user.firstName + " " + authView.user.lastName,
                  style: TextStyle(fontSize: 30),
                ),
                TextButton(
                  onPressed: () {
                    authView.logout();
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue[200],
            ),
          ),
          ListTile(
            title: Text('Transactions'),
            onTap: () {
              getIt<NavigationService>().pushTo(TRANSACTIONS);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget renderBody(CustomerView custView) {
    if (custView.loading) {
      return SpinnerWidget();
    } else {
      return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ShopWidget(
            name: custView.shops[index].shopName,
            upiId: custView.shops[index].upiId,
            city: custView.shops[index].city,
            pinCode: custView.shops[index].pinCode,
            landmark: custView.shops[index].landmark,
            category: custView.shops[index].typeOfBusiness,
            phone: custView.shops[index].phone,
          );
        },
        itemCount: custView.shops.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var authView = Provider.of<AuthView>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', textAlign: TextAlign.center),
      ),
      drawer: _renderDrawer(context, authView),
      body: ChangeNotifierProvider(
          create: (_) => CustomerView.initialize(),
          child: Consumer<CustomerView>(
            builder: (context, custView, child) {
              return renderBody(custView);
            },
          )),
    );
  }
}
