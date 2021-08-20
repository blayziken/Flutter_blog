import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  static const routeName = '/create-profile';

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: Icon(Icons.camera),
                  label: Text("Camera"),
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.image),
                  label: Text("Gallery"),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget _profileImage() {
      return Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage("assets/images/undraw_Reading_re_29f8.png"),
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

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            _profileImage(),
            customYMargin(20),
            _buildNameField(),
            customYMargin(20),
            _buildProfessionField(),
            customYMargin(20),
            _buildDOBField(),
            customYMargin(20),
            _buildTitleField(),
            customYMargin(20),
            _buildAboutField(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
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
        hintText: "Dev Stack",
      ),
    );
  }

  Widget _buildAboutField() {
    return TextFormField(
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

  //
}
