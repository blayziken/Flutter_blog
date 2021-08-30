import 'dart:convert';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:blog_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../Home/Home.dart';
import 'components/login_components.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Form Key Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // API Network Handler Call
  NetworkHandler networkHandler = NetworkHandler();

  // User validation variables
  String errorText;
  String errorText2;
  bool validate = true;
  bool spinner = false;

  // Auth Variables
  bool _isLogin = false;

  // FACEBOOK LOGIN IMPLEMENTATION
  Map data;
  final facebookLogin = FacebookLogin();

  onFBLogin() async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final response = await http.get("https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token");
        final responseData = jsonDecode(response.body);
        setState(() {
          _isLogin = true;
          data = responseData;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isLogin = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isLogin = false;
        });
        break;
    }
  }

  // NODE API LOGIN IMPLEMENTATION
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
                          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: kTextLoginPageColor),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              _buildLoginForm(),
                              customYMargin(30),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/forgot-password');
                                  },
                                ),
                              ),
                              customYMargin(30),
                              LoginButton(
                                showSpinner: spinner,
                                onTap: () async {
                                  setState(() {
                                    spinner = true;
                                  });

                                  Map<String, String> body = {
                                    "username": _usernameController.text,
                                    "password": _passwordController.text,
                                  };

                                  if (_usernameController.text == '' || _passwordController.text == '') {
                                    setState(() {
                                      validate = false;
                                      spinner = false;

                                      errorText = 'Field Cannot be Empty!';
                                      errorText2 = 'Field Cannot be Empty!';
                                    });
                                  }

                                  try {
                                    var response = await networkHandler.postData('users/login', body);

                                    if (response.statusCode == 200 || response.statusCode == 201) {
                                      Map<String, dynamic> output = json.decode(response.body);

                                      print(output['token']);
                                      await storage.write(key: "token", value: output['token']);

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ),
                                          (route) => false);

                                      setState(() {
                                        validate = true;
                                        spinner = false;
                                      });
                                    } else {
                                      setState(() {
                                        validate = false;
                                        spinner = false;
                                      });

                                      _scaffoldKey.currentState.showSnackBar(snackBar('Something went wrong'));

                                      String output = json.decode(response.body);

                                      if (output == 'Username does not exist') {
                                        setState(() {
                                          validate = false;
                                          errorText = output;
                                        });
                                      } else if (output == 'Password is incorrect') {
                                        setState(() {
                                          validate = false;
                                          errorText2 = output;
                                        });
                                      }
                                    }
                                  } catch (err) {
                                    print(err);
                                    if (err.toString().contains('SocketException')) {
                                      _scaffoldKey.currentState.showSnackBar(snackBar('Connection Error: Check your Internet Connection'));
                                    }
                                    setState(() {
                                      spinner = false;
                                    });
                                  }
                                },
                              ),
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
                                        Navigator.pushNamed(context, '/signup-screen');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              customYMargin(60),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  SocialButton(
                                    imagePath: 'assets/svg/facebook_logo2.svg',
//                                    onTap: () async {
//                                      try {
//                                        await onFBLogin();
//                                      } catch (err) {
//                                        print(err);
//                                        return;
//                                      }
//                                    },
                                  ),
                                  customXMargin(30),
                                  SocialButton(
                                    imagePath: 'assets/svg/instagram_logo2.svg',
                                    onTap: () {},
                                  ),
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
  Widget _buildUserName() {
    return Container(
      height: 35,
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          errorText: validate ? null : errorText,
        ),
        onSaved: (String value) {},
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
              keyboardType: TextInputType.visiblePassword,
              obscureText: showPassword,
              decoration: InputDecoration(
                errorText: validate ? null : errorText2,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              onSaved: (String value) {},
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
          customYMargin(10),
          _buildUserName(),
          customYMargin(30),
          Text(
            'Password',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: kTextLoginPageColor,
            ),
          ),
          customYMargin(10),
          _buildPassword(),
        ],
      ),
    );
  }
}
