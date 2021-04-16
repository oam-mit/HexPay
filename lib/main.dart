import 'package:flutter/material.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/routes.dart' as routes;
import 'package:hexpay/frontend/screens/WebView.dart';
import 'package:hexpay/frontend/screens/customer/home.dart';
import 'package:hexpay/frontend/screens/login.dart';
import 'package:hexpay/frontend/screens/payment/payment.dart';
import 'package:hexpay/frontend/screens/payment/showQR.dart';
import 'package:hexpay/frontend/screens/shopRegistration.dart';
import 'package:hexpay/frontend/screens/transactions.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:provider/provider.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthView>.value(value: getIt<AuthView>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          routes.PRELOADER: (_) => Preloader(),
          routes.LOGIN: (_) => LoginScreen(),
          routes.HOME: (_) => HomeScreen(),
          routes.TRANSACTIONS: (_) => TransactionScreen(),
          routes.PAYMENT: (_) => PaymentScreen(),
          routes.QR_CODE: (_) => QRScreen(),
          routes.SHOP_REGISTRATION: (_) => ShopRegisterScreen(),
          routes.WEB_VIEW: (_) => WebViewExample()
        },
        navigatorKey: getIt<NavigationService>().navigatorKey,
      ),
    );
  }
}

class Preloader extends StatelessWidget {
  Widget renderBody() {
    return SpinnerWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.renderBody(),
    );
  }
}
