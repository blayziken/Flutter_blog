import 'package:blog_app/screens/Profile/ProfileScreen.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'components/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

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
      appBar: buildHomeAppBar(titleString, currentState, context),
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
      bottomNavigationBar: BottomAppBar(
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
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 30,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: currentState == 1 ? Colors.white : Colors.white54,
                  onPressed: () {
                    print('a');
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ),
      ),
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
