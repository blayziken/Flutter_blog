import 'package:flutter/material.dart';

Widget bottomSheet(about) {
  return Container(
//    height: 100,
    width: double.infinity,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Text(
      about,
      style: TextStyle(fontSize: 15, color: Colors.white),
    ),
  );
}
