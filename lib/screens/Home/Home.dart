import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

import '../Profile.dart';
import 'components/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentState = 0;

  List<Widget> widgets = [
    HomeScreenBody(),
    ProfileScreen(),
  ];

  List<String> titleString = [
    "Home Page",
    "Profile Page",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: Colors.black,
                  ),
//                  Container(
//                    height: 100,
//                    width: 100,
//                    decoration: BoxDecoration(
//                      color: Colors.black,
//                      borderRadius: BorderRadius.circular(50),
//                    ),
//                  ),
                  customYMargin(10),
                  Text('@username'),
                ],
              ),
            ),
            ListTile(
              title: Text('All Posts'),
            ),
          ],
        ),
      ),
      appBar: buildHomeAppBar(titleString, currentState),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {},
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildHomeBottomAppBar(currentState),
      body: widgets[currentState],
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
