import 'package:blog_app/Model/AddBlogModel.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:flutter/material.dart';

class BlogPostCard extends StatelessWidget {
  final NetworkHandler networkHandler;
  final AddBlogModel addBlogModel;

  const BlogPostCard({Key key, this.addBlogModel, this.networkHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        height: 300,
        padding: EdgeInsets.all(5),
        width: size.width,
        child: Card(
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: networkHandler.getCoverImage(addBlogModel.id),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 55,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
//                borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      addBlogModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullPostView(),
          ),
        );
      },
    );
  }
}
