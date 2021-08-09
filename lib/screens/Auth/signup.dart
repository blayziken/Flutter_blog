import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/signup_components.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup-screen';

  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String _name, _username, _email, _password, _contact;

    Widget _inputFields(fieldName, field) {
      return Container(
        height: 30,
//        color: Colors.yellow,
        child: TextFormField(
          decoration: InputDecoration(
//            hintText: 'Your $fieldName',
//            hintStyle: TextStyle(fontSize: 10),
              ),
          validator: (String value) {
            if (value.isEmpty) {
              return '$fieldName is required';
            }
            return null;
          },
          onSaved: (String value) {
            field = value;
          },
        ),
      );
    }

    Widget _buildPassword() {
      bool showPassword = true;
      return Container(
        height: 30,
        child: TextFormField(
          decoration: InputDecoration(
//            hintText: 'Password',
//            hintStyle: TextStyle(fontSize: 13),
            suffixIcon: InkWell(
              child: Icon(
                Icons.remove_red_eye,
                color: kTextLoginPageColor,
              ),
              onTap: () {
                print('a');
              },
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          obscureText: showPassword,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
          onSaved: (String value) {
            _password = value;
          },
        ),
      );
    }

    Widget _buildSignupForm() {
      return Container(
        height: size.height * 0.4,
//        color: Colors.teal,
        child: ListView(
          padding: EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          children: [
            Form(
              key: _formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kTextLoginPageColor,
                    ),
                  ),
                  _inputFields('Email', _email),
                  customYMargin(17),
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kTextLoginPageColor,
                    ),
                  ),
                  _inputFields('Username', _username),
                  customYMargin(17),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kTextLoginPageColor,
                    ),
                  ),
                  _inputFields('Name', _username),
                  customYMargin(17),
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kTextLoginPageColor,
                    ),
                  ),
                  _inputFields('Contact Number', _contact),
                  customYMargin(17),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kTextLoginPageColor,
                    ),
                  ),
                  _buildPassword(),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.green,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: size.height * 0.65,
                  width: size.width, //double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign-up',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w900,
                              color: kTextLoginPageColor),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 10.0),
                            child: Column(
                              children: [
                                _buildSignupForm(),
                                customYMargin(20),
                                Expanded(
                                  flex: 1,
                                  child: SignupButton(
                                    formKey: _formKey2,
                                    name: _name,
                                    email: _email,
                                    contact: _contact,
                                    password: _password,
                                  ),
                                ),
//                                customYMargin(1),
                                Expanded(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Already have an account ?',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: kTextLoginPageColor,
                                          ),
                                        ),
                                        customXMargin(3),
                                        InkWell(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                              color: kTextLoginPageColor,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/login-screen');
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
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.13,
                left: size.width * 0.1,
                child: Container(
                  height: size.height * 0.25,
                  width: size.width * 0.44,
                  decoration: BoxDecoration(
                    color: Colors.black,

//                    image: DecorationImage(
//                    image: AssetImage()
//                  ),
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
