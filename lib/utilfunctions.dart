import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isValidPhoneNumber(String? string) {
  if (string == null || string.isEmpty) {
    return false;
  }
  const pattern = r'^[6-9]\d{9}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

bool isValidOTP(String? string) {
  if (string == null || string.isEmpty || string.length != 6) {
    return false;
  }
  const pattern = r'^[0-9]+$';
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

Color getButtonColor(bool isEnabled, BuildContext context) {
  return isEnabled
      ? Theme.of(context).primaryColor
      : const Color.fromRGBO(243, 243, 243, 1);
}

Route getGenericeRouteWithSideTransition(Widget page) {
  return Platform.isIOS
      ? CupertinoPageRoute(builder: (context) => page)
      : PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(2.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.decelerate;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

bool isValidEmail(String? string) {
  if (string == null || string.isEmpty) {
    return false;
  }
  const pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regExp = RegExp(pattern);
  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}
