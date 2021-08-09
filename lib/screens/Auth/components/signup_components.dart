import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required String name,
    email,
    password,
    contact,
  })  : _formKey = formKey,
        _password = password,
        _name = name,
        _email = email,
        _contact = contact,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final String _name, _email, _password, _contact;

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
      onTap: () {
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();

        print(_name);
        print(_email);
        print(_password);
        print(_contact);
      },
    );
  }
}
