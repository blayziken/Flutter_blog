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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 18.0, top: 0),
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                addBlogModel.title,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                              ),
                              customYMargin(10),
                              Row(
                                children: [
                                  Icon(Icons.chat_bubble, size: 15, color: Colors.grey),
                                  customXMargin(7),
                                  Text('0'),
                                  customXMargin(15),
                                  Icon(Icons.thumb_up, size: 15, color: Colors.grey),
                                  customXMargin(7),
                                  Text('0'),
                                  customXMargin(15),
                                  Icon(Icons.share, size: 15, color: Colors.grey),
                                  customXMargin(7),
                                  Text('0'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
//                  customYMargin(20),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 15.0),
                    child: Text(
                      addBlogModel.body,
                      style: TextStyle(
                        fontSize: 20,
//                        letterSpacing: 1,
                        wordSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
