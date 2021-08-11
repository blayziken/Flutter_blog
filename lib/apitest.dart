import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APITest extends StatefulWidget {
  @override
  _APITestState createState() => _APITestState();
}

class _APITestState extends State<APITest> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void getAPIData() async {
    Map<String, String> input = {
      "username": "testApi",
      "email": "apitesting@email.com",
      "password": "apitest123456",
      "name": "API Test",
      "contactNumber": "7259842548"
    };

    try {
      var url =
          Uri.parse('https://bloggy-backend-api.herokuapp.com/users/signup');
      var response = await http.post(url, body: input);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

//      print('-----------------------------------------------------');
//      print(await http.read('https://bloggy-backend-api.herokuapp.com/'));
//      print('-----------------------------------------------------');
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: GestureDetector(
            child: Container(
              height: 50,
              width: 150,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Click',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            onTap: () {
//              print('AA');
//              getAPIData();
            },
          ),
        ),
      ),
    );
  }
}

//router.post('/signup', authController.signup);
//
//router.post('/login', authController.login);
//
//router.patch('/updateUser', authController.protect, userController.updateUser);
//
//router.delete('/deleteUser', authController.protect, userController.deleteUser);
//
//router.get('/:userName', authController.protect, userController.getUser);
//
//// To check if username is unique
//router.get('/checkUsername/:userName', userController.checkUsername);
