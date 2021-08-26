import 'package:blog_app/Model/AddBlogModel.dart';
import 'package:blog_app/Model/SuperModel.dart';
import 'package:blog_app/screens/Blog/components/PostCard.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:flutter/material.dart';

class MyBlogPosts extends StatefulWidget {
  static const routeName = '/my-blog-posts';

  @override
  _MyBlogPostsState createState() => _MyBlogPostsState();
}

class _MyBlogPostsState extends State<MyBlogPosts> {
  bool _spinner = false;

  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    setState(() {
      _spinner = true;
    });
    var response = await networkHandler.get('posts/myBlogPosts');
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
      _spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("My Blog Posts"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: _spinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: data
                    .map(
                      (item) => BlogPostCard(
                        networkHandler: networkHandler,
                        addBlogModel: item,
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
