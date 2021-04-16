import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexpay/backend/models/WebViewArguments.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/consts/urls.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var api = Provider.of<AuthView>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/login_background.png',
              width: 300.0,
            ),
            Center(
              child: Text(
                'Hello',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text('Sign in to continue',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
              child: Material(
                elevation: 10,
                shadowColor: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Material(
                  elevation: 10,
                  shadowColor: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outlined),
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getIt<NavigationService>().pushTo(WEB_VIEW,
                            arguments: WebViewArguments(BASE_URL + "/reset"));
                      },
                      child: Text(
                        'Forgot your password ?',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    !api.loading
                        ? ElevatedButton(
                            onPressed: () {
                              api.login(_userNameController.text,
                                  _passwordController.text);
                            },
                            child: Icon(Icons.arrow_forward_outlined),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                            ))
                        : SpinnerWidget(),
                  ],
                )),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                getIt<NavigationService>().pushTo(SHOP_REGISTRATION);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text('Do not have an Account?'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
