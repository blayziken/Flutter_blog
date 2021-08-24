import 'package:blog_app/screens/Auth/login.dart';
import 'package:blog_app/screens/Profile/MainProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

AppBar buildHomeAppBar(titleString, currentState, context) {
  return AppBar(
    title: Text(titleString[currentState]),
    backgroundColor: Colors.blueGrey,
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(Icons.add_alert),
        onPressed: () async {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => MainProfileScreen(),
//            ),
//          );
        },
      ),
    ],
  );
}

//BottomAppBar buildHomeBottomAppBar(currentState) {
//  return BottomAppBar(
//    color: Colors.blueGrey,
//    shape: CircularNotchedRectangle(),
//    notchMargin: 12,
//    child: Container(
//      height: 60,
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 20.0),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            IconButton(
//              icon: Icon(Icons.home),
//              color: currentState == 0 ? Colors.white : Colors.white54,
//              onPressed: () {
//                currentState = 0;
//              },
//              iconSize: 30,
//            ),
//            IconButton(
//              icon: Icon(Icons.home),
//              color: currentState == 1 ? Colors.white : Colors.white54,
//              onPressed: () {
//                print('a');
//
//                currentState = 1;
//              },
//              iconSize: 30,
//            ),
//          ],
//        ),
//      ),
//    ),
//  );
//}
