import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  // return AppBar(
  //   title: Image.asset(
  //     "assets/images/logo.png",
  //     height: 40,
  //   ),
  //   elevation: 0.0,
  //   centerTitle: false,
  // );
  return AppBar(
    title: Text("ChatX"),
    backgroundColor: Colors.redAccent,
  );
}

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      {SnackBarAction snackBarAction,
      Color backgroundColor = Colors.redAccent}) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        backgroundColor: backgroundColor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
}
