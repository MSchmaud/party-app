import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';

// TODO move this to tone location
final primaryColor = const Color(0x464646);

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext ctxt) {
    return Container(
      color: primaryColor,
      height: MediaQuery.of(ctxt).size.height,
      width: MediaQuery.of(ctxt).size.width,
      child: SafeArea(child: Column(children: <Widget>[
        Text("Sign Up")
      ])),
    );
  }
}