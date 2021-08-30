import 'dart:io';
import 'package:blog_app/screens/Home/Home.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  static const routeName = '/create-profile';

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  bool _spinner = false;

  // Image Picker Variables
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  // Image Picker Function Call
  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  // TextForm Fields Global Key and Controllers
  final _globalKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  // API Call
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.only(left: 50, right: 50, top: 100),
          children: [
            _profileImage(),
            customYMargin(30),
            _buildNameField(),
            customYMargin(30),
            _buildProfessionField(),
            customYMargin(30),
            _buildDOBField(),
            customYMargin(30),
            _buildTitleField(),
            customYMargin(30),
            _buildAboutField(),
            customYMargin(50),
            InkWell(
              onTap: () async {
                setState(() {
                  _spinner = true;
                });

                if (_globalKey.currentState.validate()) {
                  Map<String, String> body = {
                    "name": _nameController.text,
                    "profession": _professionController.text,
                    "DOB": _dobController.text,
                    "titleline": _titleController.text,
                    "about": _aboutController.text,
                  };

                  var response = await networkHandler.postData('profiles/add', body);

//                  if (response.statusCode == 200 || response.statusCode == 201) {
//                    Map<String, dynamic> output = json.decode(response.body);
//                    }

                  if (response.statusCode == 200 || response.statusCode == 201) {
                    if (_imageFile != null) {
                      try {
                        var imageResponse = await networkHandler.patchImage('profiles/add/image', _imageFile.path).catchError((err) {
                          print(err);
                        });

                        if (imageResponse.statusCode == 200) {
                          setState(() {
                            _spinner = false;
                          });
                        }
                      } catch (err) {
                        print(err);
                      }

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false);
                    }
                  }
                }
              },
              child: Center(
                child: Container(
                  width: size.width * 0.5,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: _spinner
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            'Submit 🚀',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value.isEmpty) return "Field cannot be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Name",
        hintText: "John Doe",
      ),
    );
  }

  Widget _buildProfessionField() {
    return TextFormField(
      controller: _professionController,
      validator: (value) {
        if (value.isEmpty) return "Field cannot be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Profession",
        hintText: "Mobile Developer",
      ),
    );
  }

  Widget _buildDOBField() {
    return TextFormField(
      controller: _dobController,
      validator: (value) {
        if (value.isEmpty) return "Field cannot be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "DOB",
        hintText: "01/01/21",
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      validator: (value) {
        if (value.isEmpty) return "Field cannot be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Title",
        hintText: "Flutter Developer",
      ),
    );
  }

  Widget _buildAboutField() {
    return TextFormField(
      controller: _aboutController,
      validator: (value) {
        if (value.isEmpty) return "Field cannot be empty";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "About",
        hintText: "About you?",
      ),
    );
  }

  Widget _profileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 100.0,
            backgroundImage: _imageFile == null
                ? AssetImage("assets/images/undraw_Reading_re_29f8.png")
                : FileImage(
                    File(_imageFile.path),
                  ),
          ),
          Positioned(
            bottom: 30.0,
            right: 20.0,
            child: InkWell(
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 30,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Choose Profile Photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
