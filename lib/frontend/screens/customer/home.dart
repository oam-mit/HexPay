import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/backend/views/customerViews.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/frontend/widgets/ShopWidget.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/dialogService.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatelessWidget {
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
                    getIt<DialogService>().showYesNoDialog(
                        'Confirmation', 'Are you sure you want to logout?', () {
                      authView.logout();
                    }, type: AlertType.warning);
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
            title: Text('Transactions'),
            onTap: () {
              getIt<NavigationService>().pushTo(TRANSACTIONS);
            },
          ),
          ListTile(
            title: Text('Credits Placed'),
            onTap: () {
              getIt<NavigationService>().pushTo(CREDITS_PLACED);
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
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: HexColor('#0f1951'),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      drawer: _renderDrawer(context, authView),
      body: ChangeNotifierProvider(
          create: (_) => CustomerView.initialize(),
          child: Consumer<CustomerView>(
            builder: (context, custView, child) {
              return Stack(
                children: [
                  Image.asset('assets/images/background.png'),
                  renderBody(custView),
                ],
              );
            },
          )),
    );
  }
}
