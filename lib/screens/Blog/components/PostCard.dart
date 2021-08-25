import 'package:flutter/material.dart';

class BlogPostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 250,
      color: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
