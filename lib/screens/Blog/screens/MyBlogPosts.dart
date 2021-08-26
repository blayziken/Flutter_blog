import 'package:flutter/material.dart';

import '../BlogPosts.dart';

class MyBlogPosts extends StatelessWidget {
  static const routeName = '/my-blog-posts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: BlogPosts(
          url: "posts/myBlogPosts",
        ),
      ),
    );
  }
}
