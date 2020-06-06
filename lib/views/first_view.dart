import 'package:flutter/material.dart';
import 'package:partyApp/custom_dialog.dart';

class FirstView extends StatelessWidget{
  @override
  Widget build(BuildContext ctxt){

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;

    return Scaffold(
      body:  Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.10),
                
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 44, color: Theme.of(ctxt).primaryColor),
                ),

                SizedBox(height: _height * 0.25),

                // GET STARTED BUTTON
                RaisedButton(
                  color: Theme.of(ctxt).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: Text("Get Started",
                      style: TextStyle(
                        //color: Theme.of(ctxt).backgroundColor,
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: ctxt,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Would you like to create a free account?",
                        description: "With an account, your data will be securely saved",
                        primaryButtonText: "Create My Account",
                        primaryButtonRoute: "/signUp",
                        secondaryButtonText: "Maybe Later",
                        secondaryButtonRoute: "/home",
                      ),
                    );
                  },
                ),
                
                SizedBox(height: _height * 0.05),
                
                // SIGN IN BUTTON
                FlatButton(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Theme.of(ctxt).primaryColor, fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.of(ctxt).pushReplacementNamed('/signIn');
                  },
                ),

              ]
            ),
          ),
        ),
      ),
    );
  }
}