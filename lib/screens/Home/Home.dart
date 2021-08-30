import 'package:blog_app/Model/ProfileModel.dart';
import 'package:blog_app/screens/Blog/BlogPosts.dart';
import 'package:blog_app/screens/Profile/ProfileScreen.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'components/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentState = 0;
  bool spinner = false;

  List<Widget> widgets = [
    HomeScreenBody(),
    ProfileScreen(),
  ];

  List<String> titleString = [
    "Home Page",
    "Profile Page",
  ];

  Widget checkDrawer;

  ProfileModel profileModel = ProfileModel();
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  void fetchProfileData() async {
    setState(() {
      spinner = true;
    });

    var response = await networkHandler.get('profiles/getProfileData');

    if (response["data"] != null) {
      setState(() {
        profileModel = ProfileModel.fromJson(response["data"]);
        checkDrawer = HomeDrawer(profileModel: profileModel);
        spinner = false;
      });
    } else {
      setState(() {
        checkDrawer = NoProfileDrawer(context: context);
        spinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return spinner
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            drawer: checkDrawer,
            appBar: buildHomeAppBar(titleString, currentState, context),
            floatingActionButton: HomeFAB(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: Colors.blueGrey,
              shape: CircularNotchedRectangle(),
              notchMargin: 12,
              child: Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.home),
                        color: currentState == 0 ? Colors.white : Colors.white54,
                        onPressed: () {
                          setState(() {
                            currentState = 0;
                          });
                        },
                        iconSize: 30,
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        color: currentState == 1 ? Colors.white : Colors.white54,
                        onPressed: () {
                          print('a');
                          setState(() {
                            currentState = 1;
                          });
                        },
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: widgets[currentState],
          );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            child: BlogPosts(url: "posts/otherBlogPosts"),
          ),
        ),
      ),
    );
  }
}
