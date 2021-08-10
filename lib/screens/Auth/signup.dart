import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name;
  String _username;
  String _email;
  String _password;
  String _contact;

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  Widget _buildName() {
    return Container(
      height: 30,
      child: TextFormField(
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }
          return null;
        },
        onSaved: (String value) {
          _name = value;
        },
      ),
    );
  }

  Widget _buildUserName() {
    return Container(
      height: 30,
      child: TextFormField(
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Username is required';
          }
          return null;
        },
        onSaved: (String value) {
          _username = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      height: 30,
      child: TextFormField(
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      height: 30,
      child: TextFormField(
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Contact Number is required';
          }
          return null;
        },
        onSaved: (String value) {
          _contact = value;
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
      height: MediaQuery.of(context).size.height * 0.4,
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
                _buildName(),
                customYMargin(17),
                Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kTextLoginPageColor,
                  ),
                ),
                _buildUserName(),
                customYMargin(17),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kTextLoginPageColor,
                  ),
                ),
                _buildEmail(),
                customYMargin(17),
                Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kTextLoginPageColor,
                  ),
                ),
                _buildContact(),
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                  height: size.height * 0.7,
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
                                left: 20.0, right: 20.0, top: 20.0),
                            child: Column(
                              children: [
                                _buildSignupForm(),
                                customYMargin(30),
                                Expanded(
                                    flex: 0,
                                    child: GestureDetector(
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[900],
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'CREATE ACCOUNT',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25,
                                              letterSpacing: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        if (!_formKey2.currentState
                                            .validate()) {
                                          return;
                                        }

                                        _formKey2.currentState.save();

                                        print(_name);
                                        print(_email);
                                        print(_username);
                                        print(_password);
                                        print(_contact);
                                      },
                                    )),
                                customYMargin(10),
                                Expanded(
                                  flex: 0,
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
                top: size.height * 0.08,
                left: size.width * 0.1,
                child: Container(
                  height: size.height * 0.25,
                  width: size.width * 0.44,
                  child: SvgPicture.asset(
//                    "assets/svg/undraw_my_app_re_gxtj.svg",
//                    "assets/svg/undraw_my_files_swob.svg",
                    "assets/svg/undraw_Reading_re_29f8.svg",
                    fit: BoxFit.cover,
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
