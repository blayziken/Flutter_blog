import 'package:blog_app/Model/ProfileModel.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

NetworkHandler networkHandler = NetworkHandler();

class ImageAndNameDetails extends StatelessWidget {
  const ImageAndNameDetails({
    Key key,
    this.profileModel,
  }) : super(key: key);

  final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customYMargin(5),
        Expanded(
          flex: 4,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 130,
              backgroundImage: NetworkHandler().getImage(profileModel.username), //AssetImage("assets/images/undraw_Reading_re_29f8.png"),
            ),
          ),
        ),
        customYMargin(10),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                profileModel.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
//              customYMargin(5),
              Text(
                profileModel.titleline, //'App Developer || Full Stack Developer | Web Development | SEO',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileDeets extends StatelessWidget {
  const ProfileDeets({
    Key key,
    @required this.title,
    this.answer,
    this.icon,
  }) : super(key: key);

  final String title, answer;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.75,
      height: 85,
      decoration: BoxDecoration(
//                            color: Colors.white,
        border: Border.all(color: Colors.black54, width: 2.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customXMargin(20),
              Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
              customXMargin(30),
              Container(
                height: 50,
                width: 1,
                color: Colors.black,
              ),
              customXMargin(25),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    answer,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
