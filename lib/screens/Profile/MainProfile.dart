import 'package:blog_app/Model/ProfileModel.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatefulWidget {
  @override
  _MainProfileScreenState createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  bool _spinner = false;

  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  void fetchProfileData() async {
    setState(() {
      _spinner = true;
    });
    var response = await networkHandler.get('profiles/getProfileData');
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      _spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print('Edit');
              Navigator.pushNamed(context, '/edit-profile');
            },
            color: Colors.black,
          )
        ],
      ),
      body: _spinner
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Container(
                width: double.infinity,
                child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ImageAndNameDetails(
                        profileModel: profileModel,
                      ),
                    ),
                    customYMargin(10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue[800],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileDeets(icon: Icons.mail, title: 'Username', answer: profileModel.username),
                            ProfileDeets(icon: Icons.person, title: 'Birthday', answer: profileModel.DOB),
                            ProfileDeets(icon: Icons.local_phone, title: 'Profession', answer: profileModel.profession),
                            InkWell(
                              child: Text(
                                'About Me?',
                                style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.blueGrey,
                                  context: context,
                                  builder: ((builder) => bottomSheet(profileModel.about)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

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
              backgroundColor: Colors.transparent,
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
                color: Colors.white,
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
                      color: Colors.white54,
                    ),
                  ),
                  Text(
                    answer,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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

Widget bottomSheet(about) {
  return Container(
//    height: 100,
    width: double.infinity,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Text(
      about,
      style: TextStyle(fontSize: 15),
    ),
  );
}
