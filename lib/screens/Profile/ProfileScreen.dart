import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            GestureDetector(
              child: Container(
                height: 50,
                width: 150,
                color: Colors.green,
                child: Center(
                  child: Text('Add'),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/create-profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
