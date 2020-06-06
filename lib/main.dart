import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/views/sign_up_view.dart';
import 'package:partyApp/views/first_view.dart';
import 'package:partyApp/views/home_view.dart';
import 'package:partyApp/widgets/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt){
    return Provider(

      auth: AuthService(),

      child: MaterialApp(
        title: "Party App",
        theme: ThemeData(
          primaryColor: Colors.pink[800],
          backgroundColor: Colors.grey[800], 
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext ctxt) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext ctxt) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext ctxt) => HomeController(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    final AuthService auth = Provider.of(ctxt).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (ctxt, AsyncSnapshot<String> snapshot) {

        // If the connection state is active
        if(snapshot.connectionState == ConnectionState.active){
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView();   // If signed in, takes them to home, if not, takes them to first view
        }
        return CircularProgressIndicator();
    
    }
    );
  }
}


