import 'package:blog_app/Model/ProfileModel.dart';
import 'package:blog_app/screens/Auth/login.dart';
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

  List<Widget> widgets = [
    HomeScreenBody(),
    ProfileScreen(),
  ];

  List<String> titleString = [
    "Home Page",
    "Profile Page",
  ];

  ProfileModel profileModel = ProfileModel();
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }

  void fetchProfileData() async {
    setState(() {
//      _spinner = true;
    });
    var response = await networkHandler.get('profiles/getProfileData');
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
//      _spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      maxRadius: 70,
//                    backgroundColor: Colors.black,
                      backgroundImage: NetworkHandler().getImage(profileModel.username),
                    ),
                  ),
//                  customYMargin(10),
                  Text('@${profileModel.username}'),
                ],
              ),
            ),
            ListTile(
              title: Text('All Posts'),
              trailing: Icon(Icons.launch),
              onTap: () {
                print('aa');
              },
            ),
            ListTile(
              title: Text('New Story'),
              trailing: Icon(Icons.add),
            ),
            ListTile(
              title: Text('My Posts'),
              trailing: Icon(Icons.storage),
              onTap: () {
                Navigator.pushNamed(context, '/my-blog-posts');
              },
            ),
            ListTile(
              title: Text('Feedback'),
              trailing: Icon(Icons.feedback),
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.settings),
            ),
            ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
              trailing: Icon(Icons.logout),
              onTap: () async {
                print('Logout');
                await storage.delete(key: "token");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      appBar: buildHomeAppBar(titleString, currentState, context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.pushNamed(context, '/add-blog');
        },
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
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
      body: SingleChildScrollView(
        child: BlogPosts(
          url: "posts/otherBlogPosts",
        ),
      ),
    );
  }
}
