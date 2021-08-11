import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: GestureDetector(
            child: Container(
              height: 50,
              width: 150,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Welcome to the Bloggy',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            onTap: () {
              print('AA');
//              getAPIData();
            },
          ),
        ),
      ),
    );
  }
}
