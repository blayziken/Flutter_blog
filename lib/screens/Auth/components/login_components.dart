import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key key,
    this.imagePath,
  }) : super(key: key);

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.red,
          child: SvgPicture.asset(imagePath),
          maxRadius: 23,
        ),
      ),
      onTap: () {
        print('Social');
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required String username,
    @required String password,
  })  : _formKey = formKey,
        _username = username,
        _password = password,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final String _username;
  final String _password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            'Login',
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
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();

        print(_username);
        print(_password);
      },
    );
  }
}
