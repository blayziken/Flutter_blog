import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';

import 'components/login_components.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildUserName() {
    return Container(
      height: 35,
      child: TextFormField(
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

  Widget _buildPassword() {
    bool showPassword = true;
    return Container(
      height: 35,
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: InkWell(
            child: Icon(
              Icons.remove_red_eye,
              color: kTextLoginPageColor,
            ),
            onTap: () {
              print('a');
              setState(() {
                showPassword = false;
              });
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

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Username',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: kTextLoginPageColor,
            ),
          ),
          _buildUserName(),
          customYMargin(20),
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
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log-in',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w900,
                              color: kTextLoginPageColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              _buildLoginForm(),
                              customYMargin(10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
//                                fontWeight: FontWeight.w700,
                                    fontSize: 18,
//                                letterSpacing: 1,
                                    color: kTextLoginPageColor,
                                  ),
                                ),
                              ),
                              customYMargin(20),
                              LoginButton(
                                  formKey: _formKey,
                                  username: _username,
                                  password: _password),
                              customYMargin(20),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account ?',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: kTextLoginPageColor,
                                      ),
                                    ),
                                    customXMargin(3),
                                    InkWell(
                                      child: Text(
                                        'Sign-up',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18,
                                          color: kTextLoginPageColor,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/signup-screen');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              customYMargin(40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 1.5,
                                    width: size.width / 4.2,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'Or login with',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: kTextLoginPageColor,
                                    ),
                                  ),
                                  Container(
                                    height: 1.5,
                                    width: size.width / 4.2,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              customYMargin(30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialButton(),
                                  customXMargin(30),
                                  SocialButton(),
                                ],
                              ),
                            ],
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
                    image: DecorationImage(image: AssetImage("assets/images")
//                  ),
                        ),
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
