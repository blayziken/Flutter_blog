import 'dart:convert';
import 'package:blog_app/services/NetworkHandler.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:blog_app/utils/marginUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
//import '../../apitest.dart';
import '../Home.dart';
import 'components/login_components.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//  String _username;
//  String _password;
  bool showPassword = true;

  // TextField Form Key Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // API Network Handler Call
  NetworkHandler networkHandler = NetworkHandler();

  // User validation variables
  String errorText;
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
        final response = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token");
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
                                showSpinner: spinner,
                                onTap: () async {
                                  setState(() {
                                    spinner = true;
                                  });
                                  Map<String, String> body = {
                                    "username": _usernameController.text,
                                    "password": _passwordController.text,
                                  };

                                  var response = await networkHandler.postData(
                                      'users/login', body);

                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    Map<String, dynamic> output =
                                        json.decode(response.body);

                                    print(output['token']);
                                    await storage.write(
                                        key: "token", value: output['token']);

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
                                    String output = json.decode(response.body);
                                    print(
                                        '--------- In the else block ---------');
                                    print(output);
                                    print(
                                        '--------- In the else block ---------');

                                    setState(() {
                                      validate = false;
                                      errorText =
                                          'Username or Password is incorrect';
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
                                  SocialButton(
                                    imagePath: 'assets/svg/facebook_logo2.svg',
//                                    onTap: () async {
//                                      try {
//                                        await onFBLogin();
//                                      } catch (err) {
//                                        print('khfjdf------fdf-d--');
//                                        print(err);
//                                        return;
//                                      }
//                                      Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) => APITest(),
//                                        ),
//                                      );
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
  Widget _buildUserName() {
    return Container(
      height: 35,
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
