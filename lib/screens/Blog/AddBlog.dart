import 'dart:convert';

import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends StatefulWidget {
  static const routeName = '/add-blog';

  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
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
        minLines: 4,
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return Center(
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
          if (_imageFile != null && _formKey.currentState.validate()) {
            Map<String, String> body = {
              "title": _titleController.text,
              "body": _bodyController.text,
            };

            // POST RESPONSE
            var response = await networkHandler.postData('posts/add', body);

            if (response.statusCode == 200 || response.statusCode == 201) {
              // GETTING THIS POST ID FROM THE RESPONSE BODY SO I CAN PATCH THE COVER IMAGE
              var postId = json.decode(response.body)["data"]["postId"];

              var imageResponse = await networkHandler.patchImage('posts/$postId/addCoverImage', _imageFile.path);

              print(imageResponse.statusCode);
            }
          } else {
            print('Error: Add Blog Button - Blog not added!!!');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
