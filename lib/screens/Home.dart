import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
//        color: Colors.black,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.home), onPressed: null, iconSize: 30),
                IconButton(icon: Icon(Icons.home), onPressed: null, iconSize: 30),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Container(
            height: 50,
//              width: 150,
            color: Colors.green,
            child: Center(
              child: Text(
                'Welcome to Bloggy',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
