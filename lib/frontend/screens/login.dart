import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/routes.dart';
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
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 100,
                    height: 100,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 40),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                controller: _userNameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter Phone number'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            !api.loading
                ? Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        api.login(
                            _userNameController.text, _passwordController.text);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  )
                : SpinnerWidget(),
            SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () {
                getIt<NavigationService>().pushTo(SHOP_REGISTRATION);
              },
              child: Text(
                'New user? Register here.',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
