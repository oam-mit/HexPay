import 'package:flutter/material.dart';
import 'package:hexpay/locator.dart';
import 'package:hexpay/services/navigator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogService {
  void showAlertDialog(String title, String message, {AlertType type}) {
    Alert(
      context: getIt<NavigationService>().navigatorKey.currentContext,
      type: type != null ? type : AlertType.info,
      title: title,
      desc: message,
      style: AlertStyle(
          isCloseButton: false,
          animationDuration: Duration(seconds: 1),
          animationType: AnimationType.grow),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            Navigator.of(getIt<NavigationService>().navigatorKey.currentContext)
                .pop()
          },
          width: 120,
        )
      ],
    ).show();
  }

  void showYesNoDialog(String title, String message, Function onYes,
      {AlertType type, Function onNo}) {
    Alert(
      context: getIt<NavigationService>().navigatorKey.currentContext,
      type: type != null ? type : AlertType.info,
      title: title,
      desc: message,
      style: AlertStyle(
          isCloseButton: false,
          animationDuration: Duration(seconds: 1),
          animationType: AnimationType.grow),
      buttons: [
        DialogButton(
          color: Colors.green,
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            onYes();
            getIt<NavigationService>().pop();
          },
          width: 120,
        ),
        DialogButton(
          color: Colors.red,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>
              {onNo == null ? getIt<NavigationService>().pop() : onNo()},
          width: 120,
        )
      ],
    ).show();
  }
}
