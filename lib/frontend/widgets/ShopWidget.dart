import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/Transaction.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/consts/routes.dart';
import 'package:hexpay/consts/urls.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:provider/provider.dart';

class ShopWidget extends StatelessWidget {
  final String name;
  final String upiId;
  final String city;
  final String pinCode;
  final String landmark;
  final String category;
  final String phone;

  ShopWidget(
      {this.name,
      this.upiId,
      this.city,
      this.landmark,
      this.pinCode,
      this.category,
      this.phone});

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          getIt<NavigationService>().pushTo(PAYMENT,
              arguments: TransactionArguments(this.name, this.upiId,
                  fromPhone: authView.user.phone));
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          elevation: 10,
          shadowColor: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  BASE_URL +
                      "/media/shops/image_picker992207320091003754_wyozMpl.jpg",
                  width: 150,
                  height: 150,
                ), //TODO: Implement actual photo
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        this.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      Text(this.city +
                          "  " +
                          this.landmark +
                          "  " +
                          this.pinCode)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//           height: 220,
//           width: double.maxFinite,
//           child: Card(
//             elevation: 5,
//             child: Padding(
//               padding: EdgeInsets.all(7),
//               child: Stack(children: <Widget>[
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Stack(
//                     children: <Widget>[
//                       Padding(
//                           padding: const EdgeInsets.only(left: 10, top: 5),
//                           child: Column(
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 15.0),
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Icon(
//                                           Icons.shop,
//                                           color: Colors.amber,
//                                           size: 40,
//                                         )),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           )),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: RichText(
//                           text: TextSpan(
//                             text: this.name,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                                 fontSize: 20),
//                             children: <TextSpan>[
//                               TextSpan(
//                                   text:
//                                       '\n${this.city} ${this.landmark} ${this.pinCode}',
//                                   style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Row(
//                             children: <Widget>[
//                               RichText(
//                                 textAlign: TextAlign.left,
//                                 text: TextSpan(
//                                   text: '\nCategory:',
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 35,
//                                   ),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                         text: '  ${this.category}',
//                                         style: TextStyle(
//                                             color: Colors.grey,
//                                             fontStyle: FontStyle.italic,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold)),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ]),
//             ),
//           ))
