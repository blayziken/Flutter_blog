import 'package:blog_app/Model/AddBlogModel.dart';
import 'package:blog_app/Model/SuperModel.dart';
import 'package:blog_app/screens/Blog/components/PostCard.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

class BlogPosts extends StatefulWidget {
  final String url;

  const BlogPosts({Key key, this.url}) : super(key: key);

  @override
  _BlogPostsState createState() => _BlogPostsState();
}

class _BlogPostsState extends State<BlogPosts> {
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
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
      _spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _spinner
        ? Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            backgroundColor: Colors.blueGrey,
          ))
        : data.length > 0
            ? Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: data
                      .map((item) => Column(
                            children: [
                              BlogPostCard(
                                networkHandler: networkHandler,
                                addBlogModel: item,
                              ),
                              customYMargin(20),
                            ],
                          ))
                      .toList(),
                ),
              )
            : Center(
                child: Text('No Blog Posts Yet'),
              );
  }
}

//_spinner
//? Center(
//child: CircularProgressIndicator(),
//)
//:

//@override
//Widget build(BuildContext context) {
//  return _spinner
//      ? Center(
//    child: CircularProgressIndicator(),
//  )
//      : data.length > 0
//      ? Padding(
//    padding: EdgeInsets.all(20.0),
//    child: Column(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: data
//          .map((item) => Column(
//        children: [
//          BlogPostCard(
//            networkHandler: networkHandler,
//            addBlogModel: item,
//          ),
//          customYMargin(30),
//        ],
//      ))
//          .toList(),
//    ),
//  )
//      : Center(
//    child: Text('No Blog Posts Yet'),
//  );
//}
//}
