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
  @override
  Widget build(BuildContext context) {
    // Image Picker
    PickedFile _imageFile;
    final ImagePicker _picker = ImagePicker();
    IconData iconphoto = Icons.image;

    void takeCoverPhoto() async {
      final coverPhoto = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        iconphoto = Icons.check_box;
        _imageFile = coverPhoto;
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
              onPressed: takeCoverPhoto,
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
          onTap: () {},
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
        ),
      );
    }

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
        actions: [
          FlatButton(
            onPressed: null,
            child: Text(
              'Preview',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )
        ],
      ),
      body: ListView(
        key: _formKey,
        children: [
          titleTextField(),
          customYMargin(10),
          bodyTextField(),
          customYMargin(50),
          addButton(),
        ],
      ),
    );
  }
}
