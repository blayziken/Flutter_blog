import 'dart:io';
import 'package:blog_app/screens/Home/Home.dart';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // API Call
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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

                Map<String, String> body = {
                  "name": _nameController.text,
                  "profession": _professionController.text,
                  "dob": _dobController.text,
                  "title": _titleController.text,
                  "about": _aboutController.text,
                };

                // Removing empty fields
                body.removeWhere((key, value) => value.isEmpty);

                // Checking if user did not update a field
                if (body.length == 0 && _imageFile == null) {
                  setState(() {
                    _spinner = false;
                  });
                  final snackBar = SnackBar(
                    content: Text('You have to update at least a field'),
                    backgroundColor: Colors.red,
                  );
                  return _scaffoldKey.currentState.showSnackBar(snackBar);
                }

                var response = await networkHandler.patchData('profiles/update', body);

                if (response.statusCode == 200 || response.statusCode == 201) {
                  print('Updated Profile');
                  if (_imageFile != null) {
                    var imageResponse = await networkHandler.patchImage('profiles/add/image', _imageFile.path);
                    if (imageResponse.statusCode == 200) {
                      setState(() {
                        _spinner = false;
                      });
                    }
                  } else {
                    setState(() {
                      _spinner = false;
                    });
                  }

                  final snackBar2 = SnackBar(
                    content: Text('Profile Updated Successfully'),
                    backgroundColor: Colors.green,
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar2);

                  setState(() {
                    _spinner = false;
                  });

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false);
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
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            customYMargin(50),
            Center(
              child: Text(
                'Only update the fields you want, leave the rest',
                style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
//        if (value.isEmpty) return "Field cannot be empty";

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
//        if (value.isEmpty) return "Field cannot be empty";

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
//        if (value.isEmpty) return "Field cannot be empty";

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
//        if (value.isEmpty) return "Field cannot be empty";

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
//        if (value.isEmpty) return "Field cannot be empty";

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
