import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';

enum AuthFormType {signIn, signUp}

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {

  // Require that we get an authformtype
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  // Formkey and string global variables
  final formKey = GlobalKey<FormState>();
  String _email, _password, _username;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if(state == "signUp"){
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    }else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  @override
  Widget build(BuildContext ctxt) {

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;

    return Scaffold(
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget> [
              SizedBox(height: _height * 0.05),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),

              // ACTUAL SIGN UP FORM
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              ),
              

            ],
          ),
        ),
      ),
    );
    
  }

  // Build Input method =================================================================
  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    // If we are in sign up state add username
    if(authFormType == AuthFormType.signUp){
      textFields.add(
        TextFormField(
          style: TextStyle(fontSize: 22.0, color: Colors.pink[800]),
          decoration: buildSignUpInputDecoration("Username"),
          onSaved: (value) => _username = value,
        ),
      );
    }
    
    // Spacing
    textFields.add(SizedBox(height: 20));

    // add email and password
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0, color: Colors.pink[800]),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    
    // Spacing
    textFields.add(SizedBox(height: 20));

    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0, color: Colors.pink[800]),
        decoration: buildSignUpInputDecoration("Password"),
        onSaved: (value) => _password = value,
      ),
    );

    // Spacing
    textFields.add(SizedBox(height: 20));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
          hintText: hint,
          //filled: true,
          //fillColor: Colors.grey,
          focusColor: Colors.pink[800],
          //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.0)),
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  // BUILD HEADER METHOD ======================================================================
  Text buildHeaderText() {
    String _headerText;
    if(authFormType == AuthFormType.signUp){
      _headerText = "Create New Account";
    }else{
      _headerText = "Sign in";
    }

    return Text(
      _headerText,
      style: TextStyle(
        fontSize: 35,
        color: Colors.pink[800],
      ),
    );
  }

  // BUILD BUTTONS METHOD ========================================================================
  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState;

    if(authFormType == AuthFormType.signIn){
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
    }else{
      _switchButtonText = "Already Have an Account? Sign In";
      _newFormState = "signIn";
    }

    return  [
      FlatButton(
         child: Text(_switchButtonText, style: TextStyle(color: Colors.white),),
         onPressed: () {
           switchFormState(_newFormState);
         },
      ),
    ];
  }

}