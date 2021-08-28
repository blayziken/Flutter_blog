import 'package:blog_app/Model/AddBlogModel.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

class FullPostView extends StatelessWidget {
  final NetworkHandler networkHandler;

  final AddBlogModel addBlogModel;

  const FullPostView({Key key, this.addBlogModel, this.networkHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
//                color: Colors.red,
                  image: DecorationImage(
                    image: networkHandler.getCoverImage(addBlogModel.id),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
//            customYMargin(5),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addBlogModel.title,
                      style: TextStyle(fontSize: 30),
                    ),
                    customYMargin(10),
                    Text(
                      addBlogModel.body,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        wordSpacing: 3.0,
                      ),
                    ),
//                  Container(
//                    color: Colors.red,
//                    width: double.infinity,
//                    height: 200,
//                  ),
                  ],
                ),
              ),
//            Spacer(),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Likes: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Comments: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Shares: ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              customYMargin(10),
            ],
          ),
        ),
      ),
    );
  }
}
