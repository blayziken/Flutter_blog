import 'package:blog_app/Model/AddBlogModel.dart';
import 'package:blog_app/Model/Super.dart';
import 'package:blog_app/screens/Blog/components/PostCard.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:flutter/material.dart';

class MyBlogPosts extends StatefulWidget {
  static const routeName = '/my-blog-posts';

  @override
  _MyBlogPostsState createState() => _MyBlogPostsState();
}

class _MyBlogPostsState extends State<MyBlogPosts> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    var response = await networkHandler.get('posts/myBlogPosts');
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map((item) => BlogPostCard()).toList(),
    );
  }
}
