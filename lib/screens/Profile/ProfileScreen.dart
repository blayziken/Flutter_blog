import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // API Call
  NetworkHandler networkHandler = NetworkHandler();

  Widget currentScreen = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get('profiles/checkProfile');
    if (response["status"] == true) {
      setState(() {
        currentScreen = showProfile();
      });
    } else {
      setState(() {
        currentScreen = defaultScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: defaultScreen(), //currentScreen,
    );
  }

  Widget showProfile() {
    return Center(child: Text('Profile Available'));
  }

  Widget defaultScreen() {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Container(
//          color: Colors.teal,
          width: double.infinity,
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ImageAndNameDetails(),
              ),
              customYMargin(30),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  color: Colors.blue[800],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileDeets(icon: Icons.local_phone, title: 'Phone Number', answer: '+2345454234'),
                      ProfileDeets(icon: Icons.mail, title: 'Email', answer: 'kingtoluwalope@gmail.com'),
                      ProfileDeets(icon: Icons.person, title: 'Something', answer: 'Something'),
                      InkWell(
                        child: Text(
                          'About Me?',
                          style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.blueGrey,
                            context: context,
                            builder: ((builder) => bottomSheet()),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 90,
            backgroundImage: AssetImage("assets/images/undraw_Reading_re_29f8.png"), // NetworkHandler().getImage("postman1")
          ),
        ),
        customYMargin(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Postman Test',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            customYMargin(5),
            Text(
              'App Developer || Full Stack Developer | Web Development | SEO',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
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

Widget bottomSheet() {
  return Container(
//    height: 100,
    width: double.infinity,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Text(
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      style: TextStyle(fontSize: 15),
    ),
  );
}
