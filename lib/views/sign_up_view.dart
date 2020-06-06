import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/widgets/provider.dart';

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
  String _email, _password, _username, _error;

  // METHOD FOR SWITCHING STATE
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

  // Check for field validation
  bool validate() {
    final form = formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      return true;
    }else {
      return false;
    }
  }

  // SUBMIT BUTTON METHOD
  void submit() async {
    if(validate()){
      try {
        final auth = Provider.of(context).auth;
        if(authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed In with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }else{
          String uid = await auth.createUserWithEmailAndPassword(_email, _password, _username);
          print("Signed up with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e){
        setState(() {
          _error = e.message;
        });
        print(e);
      }
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
              SizedBox(height: _height * 0.025),
              showAlert(),
              SizedBox(height: _height * 0.025),
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

    // ADD USERNAME IF IN SIGN UP STATE
    if(authFormType == AuthFormType.signUp){
      textFields.add(
        TextFormField(
          validator: UsernameValidator.validate,
          style: TextStyle(fontSize: 22.0, color: Theme.of(context).primaryColor),
          decoration: buildSignUpInputDecoration("Username"),
          onSaved: (value) => _username = value,
        ),
      );
    }

    textFields.add(SizedBox(height: 20));

    // ADD EMAIL
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 22.0, color: Theme.of(context).primaryColor),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );

    textFields.add(SizedBox(height: 20));

  // ADD PASSWORD
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 22.0, color: Theme.of(context).primaryColor),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
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
          focusColor: Theme.of(context).primaryColor,
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
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  // BUILD BUTTONS METHOD ========================================================================
  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;

    if(authFormType == AuthFormType.signIn){
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
    }else{
      _switchButtonText = "Already Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return  [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_submitButtonText, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300)),
          ),
          onPressed: () {
            submit();
          })
      ),

      FlatButton(
         child: Text(_switchButtonText, style: TextStyle(color: Colors.white),),
         onPressed: () {
           switchFormState(_newFormState);
         },
      ),
    ];
  }

  // SHOW ALERT METHOD =======================================================================
  Widget showAlert() {
    if(_error != null){
      return Container(
        color: Colors.red,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: Text(_error)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
            
          ],
        ),
      );
    }
    return SizedBox(height: 0.0);
  }

}