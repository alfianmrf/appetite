import 'package:flutter/material.dart';

class AppColor {
  static const MaterialColor primarySwatch = MaterialColor(
    0xff6c60e1,
    <int, Color>{
      50: Color.fromRGBO(108, 96, 225, .1),
      100: Color.fromRGBO(108, 96, 225, .2),
      200: Color.fromRGBO(108, 96, 225, .3),
      300: Color.fromRGBO(108, 96, 225, .4),
      400: Color.fromRGBO(108, 96, 225, .5),
      500: Color.fromRGBO(108, 96, 225, .6),
      600: Color.fromRGBO(108, 96, 225, .7),
      700: Color.fromRGBO(108, 96, 225, .8),
      800: Color.fromRGBO(108, 96, 225, .9),
      900: Color.fromRGBO(108, 96, 225, 1),
    },
  );

  static const Color primary = Color(0xff6c60e1);
  static const Color background = Color(0xffF8F9FF);
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color text = Color(0xff58586B);
  static const Color price = Color(0xff32876A);
}