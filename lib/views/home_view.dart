import 'package:flutter/material.dart';
import 'package:partyApp/widgets/provider.dart';
import 'package:partyApp/services/auth_service.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext ctxt){
    return Scaffold(
      body:  Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Home Page"),

              // Sign out button
              IconButton(
                icon: Icon(Icons.undo),
                onPressed: () async {
                  try{
                    AuthService auth = Provider.of(ctxt).auth;
                    await auth.signOut();
                    print("signed Out!");
                  } catch (e){
                    print(e);
                  }
                }
              ),

            ]
          ),
        ),
      ),
    );
  }
}