import 'package:flutter/material.dart';

class ForgotButton extends StatelessWidget {
  final Function onTap;
  final bool showSpinner;

  const ForgotButton({Key key, this.onTap, this.showSpinner}) : super(key: key);

//  final GlobalKey<FormState> _formKey;
//  final String _username;
//  final String _password;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
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
                  'Update',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
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
