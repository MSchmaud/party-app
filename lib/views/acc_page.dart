import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/widgets/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt){

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.undo),
            tooltip: 'Sign Out',
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
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[

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

  final List<String> partiesList = [
    "Party 1", "Party 2", "Party 3", "Party 4"
  ];

  @override
  Widget build(BuildContext ctxt) {

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Parties'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Go Back',
            onPressed: () {
              // ADD A NEW CARD
            },
          ),
        ]
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: new ListView.builder(
            itemCount: partiesList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Text(index.toString()),
                      Text(partiesList[index]),
                    ],
                  )
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}