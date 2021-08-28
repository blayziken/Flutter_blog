import 'package:blog_app/screens/Auth/forgot_password.dart';
import 'package:blog_app/screens/Auth/login.dart';
import 'package:blog_app/screens/Auth/signup.dart';
import 'package:blog_app/screens/Blog/screens/AddBlog.dart';
import 'package:blog_app/screens/Blog/screens/MyBlogPosts.dart';
import 'package:blog_app/screens/Home/Home.dart';
import 'package:blog_app/screens/Profile/CreateProfile.dart';
import 'package:blog_app/screens/Profile/EditProfile.dart';
import 'package:blog_app/screens/Profile/ProfileScreen.dart';
import 'package:blog_app/screens/Splash.dart';
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
        currentScreen = SplashScreen();
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
        // Splash Screen
        SplashScreen.routeName: (context) => SplashScreen(),

        // Auth Screens
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ForgotPassword.routeName: (context) => ForgotPassword(),

        // Home
        HomeScreen.routeName: (context) => HomeScreen(),

        // Profile Screens
        ProfileScreen.routeName: (context) => ProfileScreen(),
        CreateProfile.routeName: (context) => CreateProfile(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),

        // Blog Routes
        AddBlogScreen.routeName: (context) => AddBlogScreen(),
        MyBlogPosts.routeName: (context) => MyBlogPosts(),
      },
    );
  }
}
