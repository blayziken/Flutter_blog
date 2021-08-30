import 'package:blog_app/Model/ProfileModel.dart';
import 'package:blog_app/screens/Auth/login.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final storage = FlutterSecureStorage();

NetworkHandler networkHandler = NetworkHandler();

AppBar buildHomeAppBar(titleString, currentState, context) {
  return AppBar(
    title: Text(titleString[currentState]),
    backgroundColor: Colors.blueGrey,
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(Icons.add_alert),
        onPressed: () async {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => MainProfileScreen(),
//            ),
//          );
        },
      ),
    ],
  );
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
    @required this.profileModel,
  }) : super(key: key);

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    if (profileModel == null) {
      print('NUll Null Null Null');
//      username = ''
    }
    return Drawer(
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
            onTap: () {
              Navigator.pushNamed(context, '/add-blog');
            },
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
    );
  }
}

class NoProfileDrawer extends StatelessWidget {
  const NoProfileDrawer({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Expanded(
                child: CircleAvatar(
                  maxRadius: 70,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    FontAwesomeIcons.snowman,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        customYMargin(20),
        Center(
          child: Text(
            'No Profile Yet',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        customYMargin(10),
        InkWell(
          child: Center(
            child: Text(
              'Create one here',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
            ),
          ),
          onTap: () => Navigator.pushNamed(context, '/create-profile'),
        ),
      ],
    ));
  }
}

class HomeFAB extends StatelessWidget {
  const HomeFAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}
