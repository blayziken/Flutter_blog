import 'dart:convert';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:blog_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/forgotPassword_components.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _spinner = false;

  bool showPassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  NetworkHandler networkHandler = NetworkHandler();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                          'Forgot Password',
                          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: kTextLoginPageColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 50.0, right: 20.0),
                          child: Column(
                            children: [
                              _buildLoginForm(),
                              customYMargin(40),
                              ForgotButton(
                                showSpinner: _spinner,
                                onTap: () async {
                                  setState(() {
                                    _spinner = true;
                                  });

                                  Map<String, String> body = {
                                    "password": _passwordController.text,
                                  };

                                  try {
                                    var updateResponse = await networkHandler.patchData('users/updateUser/${_usernameController.text}', body);

                                    if (updateResponse.statusCode == 200 || updateResponse.statusCode == 201) {
                                      _scaffoldKey.currentState.showSnackBar(snackBar('Password Updated Successfully'));

                                      setState(() {
                                        _spinner = false;
                                      });

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                          (route) => false);
                                    } else {
                                      setState(() {
                                        _spinner = false;
                                      });
                                      _scaffoldKey.currentState.showSnackBar(snackBar('Something went wrong'));

                                      String output = json.decode(updateResponse.body);
                                      print('--------- In the else block ---------');
                                      print(output);
                                      print('--------- In the else block ---------');
                                    }
                                  } catch (err) {
                                    if (err.toString().contains('SocketException')) {
                                      print('Connection Error : $err');

                                      _scaffoldKey.currentState.showSnackBar(snackBar('Connection Error: Check your Internet Connection'));
                                    }
                                    setState(() {
                                      _spinner = false;
                                    });
                                  }
                                },
                              ),
                              customYMargin(20),
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

  Widget _buildUserName() {
    return Container(
      height: 35,
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(),
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

  Widget _buildPassword() {
    return Container(
      height: 35,
      child: Row(
        children: [
          Expanded(
            flex: 15,
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(

//              suffixIcon: IconButton(
//                icon: Icon(
//                  showPassword ? Icons.visibility_off : Icons.visibility,
//                  color: kTextLoginPageColor,
//                ),
//                onPressed: () {
//                  setState(
//                    () {
//                      showPassword = !showPassword;
//                    },
//                  );
//                },
//              ),
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
//          _password = value;
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                color: kTextLoginPageColor,
              ),
              onPressed: () {
                setState(
                  () {
                    showPassword = !showPassword;
                  },
                );
              },
            ),
          ),
        ],
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
}
