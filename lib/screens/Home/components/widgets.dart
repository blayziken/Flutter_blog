import 'package:flutter/material.dart';

AppBar buildHomeAppBar(titleString, currentState) {
  return AppBar(
    title: Text(titleString[currentState]),
    backgroundColor: Colors.blueGrey,
    centerTitle: true,
    actions: [IconButton(icon: Icon(Icons.add_alert), onPressed: () {})],
  );
}

BottomAppBar  buildHomeBottomAppBar(currentState) {
  return BottomAppBar(
    color: Colors.blueGrey,
    shape: CircularNotchedRectangle(),
    notchMargin: 12,
    child: Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: currentState == 0 ? Colors.white : Colors.white54,
              onPressed: () {
                currentState = 0;
              },
              iconSize: 30,
            ),
            IconButton(
              icon: Icon(Icons.home),
              color: currentState == 1 ? Colors.white : Colors.white54,
              onPressed: () {
                currentState = 1;
              },
              iconSize: 30,
            ),
          ],
        ),
      ),
    ),
  );
}
