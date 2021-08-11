import 'package:blog_app/services/NetworkHandler.dart';
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
//  String _name;
//  String _username;
//  String _email;
//  String _password;
//  String _contact;
  bool showPassword = true;

  // API Network Handler Call
  NetworkHandler networkHandler = NetworkHandler();

  // TextField Form Key Controllers
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  // User validation variables
  String errorText;
  bool validate = true;
  bool spinner = false;

  // To check if user exists:
  checkUser() async {
    String usernameText = _usernameController.text;
    if (usernameText.length == 0) {
      setState(() {
//        spinner = false;
        validate = false;
        errorText = 'Username cannot be empty';
      });

      return;
    }

    print(usernameText);

    var response =
        await networkHandler.get('users/checkUsername/$usernameText');

    if (response["status"]) {
      setState(() {
//        spinner = false;
        validate = false;
        errorText = 'Username already exists';
      });
    } else {
      setState(() {
//        spinner = false;
        validate = true;
      });
    }

    print('--------------------------------------');
    print(response);
//    print(validate);
    print('--------------------------------------');
  }

//
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
                                    child: spinner
                                        ? CircularProgressIndicator()
                                        : Container(
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
                                    onTap: () async {
                                      setState(() {
                                        spinner = true;
                                      });

                                      await checkUser();

                                      if (_formKey2.currentState.validate() &&
                                          validate) {
                                        Map<String, String> body = {
                                          "name": _nameController.text,
                                          "username": _usernameController.text,
                                          "email": _emailController.text,
                                          "password": _passwordController.text,
                                          "contactNumber":
                                              _contactController.text,
                                        };

                                        await networkHandler.postData(
                                            'users/signup', body);

                                        setState(() {
                                          spinner = false;
                                        });
                                      } else {
                                        print('Error at submit button');
                                        setState(() {
                                          spinner = false;
                                        });
                                      }

//                                      _formKey2.currentState.save();
                                    },
                                  ),
                                ),
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

  // TextField Widgets
  Widget _buildName() {
    return Container(
      height: 30,
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }
          return null;
        },
//        onSaved: (String value) {
//          _name = value;
//        },
      ),
    );
  }

  Widget _buildUserName() {
    return Container(
      height: 30,
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          errorText: validate ? null : errorText,
        ),
//        validator: (String value) {
//          if (value.isEmpty) {
//            return 'Username is required';
//          }
//          return null;
//        },
        onSaved: (String value) {
//          _username = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      height: 30,
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }
          if (!value.contains('@')) {
            return 'Invalid Email';
          }
          return null;
        },
//        onSaved: (String value) {
//          _email = value;
//        },
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      height: 30,
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Contact Number is required';
          }
          return null;
        },
        onSaved: (String value) {
//          _contact = value;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      height: 30,
      child: TextFormField(
        controller: _contactController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: kTextLoginPageColor,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
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
          if (value.length < 8) {
            return 'Password must have 8 or more characters';
          }
          return null;
        },
        onSaved: (String value) {
//          _password = value;
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
}
