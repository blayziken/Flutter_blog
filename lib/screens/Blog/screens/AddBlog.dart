import 'dart:convert';
import 'package:blog_app/screens/Home/Home.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:blog_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends StatefulWidget {
  static const routeName = '/add-blog';

  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  bool _spinner = false;

  // Image Picker
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  IconData iconphoto = Icons.image;

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = coverPhoto;
      iconphoto = Icons.check_box;
    });
  }

  // TextField Form Key Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  // API Network Handler Call
  NetworkHandler networkHandler = NetworkHandler();

  // For SnackBar
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget titleTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _titleController,
        validator: (value) {
          if (value.isEmpty)
            return "Insert a title";
          else if (value.length > 100) return "Length must be less than 100";

          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "Add Image and Title",
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Colors.teal,
            ),
            onPressed: () {
              print('take photo');
              takeCoverPhoto();
            },
          ),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _bodyController,
        validator: (value) {
          if (value.isEmpty) return "No body 😶";

          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "......",
        ),
        minLines: 20,
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return _spinner
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: InkWell(
              child: Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.teal),
                child: Center(
                  child: Text(
                    'Add Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                setState(() {
                  _spinner = true;
                });

                if (_imageFile == null) {
                  setState(() {
                    _spinner = false;
                  });

                  return _scaffoldKey.currentState.showSnackBar(snackBar('Cover Image Needed'));
                }

                if (_imageFile != null && _formKey.currentState.validate()) {
                  Map<String, String> body = {
                    "title": _titleController.text,
                    "body": _bodyController.text,
                  };

                  try {
                    // POST RESPONSE
                    var response = await networkHandler.postData('posts/add', body);

                    if (response.statusCode == 200 || response.statusCode == 201) {
                      // GETTING THIS POST ID FROM THE RESPONSE BODY SO I CAN PATCH THE COVER IMAGE
                      var postId = json.decode(response.body)["data"]["postId"];

                      var imageResponse = await networkHandler.patchImage('posts/$postId/addCoverImage', _imageFile.path);

                      if (imageResponse.statusCode == 200 || response.statusCode == 201) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                            (route) => false);
                      }
                      if (imageResponse.statusCode == 404) {
                        setState(() {
                          _spinner = false;
                        });

                        return _scaffoldKey.currentState.showSnackBar(snackBar('Something went wrong...Try again'));
                      }
                    }

                    if (response.statusCode == 404) {
                      setState(() {
                        _spinner = false;
                      });

                      return _scaffoldKey.currentState.showSnackBar(snackBar('Something went wrong...Try again'));
                    }
                  } catch (err) {
                    if (err.toString().contains('SocketException')) {
                      print('Connection Error : $err');

                      _scaffoldKey.currentState.showSnackBar(snackBar('Connection Error: Check your Internet Connection'));
                    }
                    setState(() {
                      _spinner = false;
                    });
                  }
                } else {
                  setState(() {
                    _spinner = false;
                  });
                }
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            titleTextField(),
            customYMargin(10),
            bodyTextField(),
            customYMargin(50),
            addButton(),
          ],
        ),
      ),
    );
  }
}
