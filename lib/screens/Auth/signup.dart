import 'dart:convert';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:blog_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import '../Home/Home.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

    try {
      var response = await networkHandler.get('users/checkUsername/$usernameText');

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
    } catch (err) {
      if (err.toString().startsWith('SocketException')) {
        _scaffoldKey.currentState.showSnackBar(snackBar('Connection Error: Check your Internet Connection'));
      }
      setState(() {
        spinner = false;
      });
    }
  }

// Storing token:
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          color: Colors.blueGrey,
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
                    padding: EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign-up',
                          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: kTextLoginPageColor),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Center(
                                        child: spinner
                                            ? CircularProgressIndicator()
                                            : Text(
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

                                      if (_formKey2.currentState.validate() && validate) {
                                        Map<String, String> body = {
                                          "name": _nameController.text,
                                          "username": _usernameController.text,
                                          "email": _emailController.text,
                                          "password": _passwordController.text,
                                          "contactNumber": _contactController.text,
                                        };

                                        try {
                                          //Signup route
                                          var responseRegister = await networkHandler.postData('users/signup', body);

                                          if (responseRegister.statusCode == 200 || responseRegister.statusCode == 201) {
                                            Map<String, String> data = {
                                              "username": _usernameController.text,
                                              "password": _passwordController.text,
                                            };

                                            // Login route
                                            var response = await networkHandler.postData('users/login', data);

                                            if (response.statusCode == 200 || response.statusCode == 201) {
                                              Map<String, dynamic> output = json.decode(response.body);

                                              await storage.write(key: "token", value: output['token']);

                                              setState(() {
                                                validate = true;
                                                spinner = false;
                                              });

                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
                                            }
                                          }

                                          if (responseRegister.statusCode == 500) {
                                            print(responseRegister.body);
                                            _scaffoldKey.currentState.showSnackBar(snackBar('Connection Error: Please try again'));
                                            setState(() {
                                              spinner = false;
                                            });
                                          }
                                        } catch (err) {
                                          print(err);
                                          if (err.toString().contains('SocketException')) {
                                            setState(() {
                                              spinner = false;
                                            });
                                          }

                                          if (err.toString().startsWith('SocketException')) {

                                            _scaffoldKey.currentState.showSnackBar(snackBar('Connection Error: Check your Internet Connection'));
                                          }
                                          setState(() {
                                            spinner = false;
                                          });
                                        }
                                      }

                                      setState(() {
                                        spinner = false;
                                      });
                                    },
                                  ),
                                ),
//                                customYMargin(10),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                            Navigator.pushNamed(context, '/login-screen');
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: _nameController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Name is required';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            ),
          ),
          labelText: "Name",
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          errorText: validate ? null : errorText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            ),
          ),
          labelText: "Username",
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: _emailController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }
          if (!value.contains('@')) {
            return 'Invalid Email';
          }
          if (!value.contains('.com')) {
            return 'Invalid Email';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            ),
          ),
          labelText: "Email Address",
        ),
      ),
    );
  }

  Widget _buildContact() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: _contactController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Contact Number is required';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            ),
          ),
          labelText: "Contact",
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: _passwordController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is required';
          }
          if (value.length < 8) {
            return 'Password must have 8 or more characters';
          }
          return null;
        },
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
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2,
            ),
          ),
          labelText: "Password",
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: showPassword,
      ),
    );
  }

  Widget _buildSignupForm() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Form(
        key: _formKey2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildName(),
              _buildUserName(),
              _buildEmail(),
              _buildContact(),
              _buildPassword(),
            ],
          ),
        ),
      ),
    );
  }
}
