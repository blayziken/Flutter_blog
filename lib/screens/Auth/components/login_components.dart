import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key key,
    this.imagePath,
    this.onTap,
  }) : super(key: key);

  final String imagePath;
  final Function onTap;

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
      onTap: onTap,
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function onTap;
  final bool showSpinner;

  const LoginButton({Key key, this.onTap, this.showSpinner}) : super(key: key);

//  final GlobalKey<FormState> _formKey;
//  final String _username;
//  final String _password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey[900],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: showSpinner
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )
              : Text(
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
      onTap: onTap,
    );
  }
}
