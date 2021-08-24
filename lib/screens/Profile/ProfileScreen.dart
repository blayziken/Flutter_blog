import 'package:blog_app/services/NetworkHandler.dart';
import 'package:flutter/material.dart';

import 'MainProfile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // API Call
  NetworkHandler networkHandler = NetworkHandler();

  Widget currentScreen = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get('profiles/checkProfile');
    if (response["status"] == true) {
      setState(() {
        currentScreen = MainProfileScreen();
      });
    } else {
      setState(() {
        currentScreen = noProfileScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
    );
  }

  Widget showProfile() {
    return Center(child: Text('Profile Available'));
  }

  Widget noProfileScreen() {
    return Container(
      child: Center(
        child: InkWell(
          child: Text(
            'Click to Add a Profile',
            style: TextStyle(fontSize: 25, color: Colors.blueGrey),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/create-profile');
          },
        ),
      ),
    );
  }
}
