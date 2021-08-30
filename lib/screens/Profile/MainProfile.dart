import 'package:blog_app/Model/ProfileModel.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

import 'components/MainProfile_Widgets.dart';
import 'components/Modal_Bottom_Sheet.dart';

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
//                        color: Colors.black12,
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
                                style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.blueGrey[800],
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
