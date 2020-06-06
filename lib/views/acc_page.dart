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

              // DO ALL ACCOUNT STUFF HERE

              RaisedButton(
                color: Theme.of(ctxt).primaryColor,
                child: Text(
                  "My Parties"
                ),
                onPressed: () {
                  Navigator.push(ctxt, MaterialPageRoute(builder: (context) => PartyList()));
                }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// PAGE FOR THE PARTY LIST ROUTE
class PartyList extends StatelessWidget {
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
            children: <Widget>[
              Text("Party List", style: TextStyle(color: Colors.white)),
              RaisedButton(
                color: Theme.of(ctxt).primaryColor,
                child: Text(
                  "Back"
                ),
                onPressed: () {
                  Navigator.pop(ctxt);
                }
              ),
            ]
          )
        ),
      ),
    );
  }
}