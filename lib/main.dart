import 'package:blog_app/screens/Auth/login.dart';
import 'package:blog_app/screens/Auth/signup.dart';
import 'package:blog_app/screens/Home/Home.dart';
import 'package:blog_app/screens/Profile/CreateProfile.dart';
import 'package:blog_app/screens/Profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentScreen = LoginScreen();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: 'token');
    if (token != null) {
      setState(() {
        currentScreen = HomeScreen();
      });
    } else {
      setState(() {
        currentScreen = LoginScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: currentScreen,
      routes: {
        // Auth Screens
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),

        // Home
        HomeScreen.routeName: (context) => HomeScreen(),

        // Profile Screens
        ProfileScreen.routeName: (context) => ProfileScreen(),
        CreateProfile.routeName: (context) => CreateProfile(),
      },
    );
  }
}
