import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/widgets/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt){

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;

    return Scaffold(
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Account Page"),
              // Sign out button
              IconButton(
                color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}