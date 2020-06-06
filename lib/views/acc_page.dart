import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/widgets/provider.dart';
import 'package:partyApp/models/party.dart';
import 'package:intl/intl.dart';

// Account page ======================================================================
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

              // DO ALL ACCOUNT STUFF HERE //////////////////////////////////

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

// PAGE FOR THE PARTY LIST ROUTE ===========================================================================
class PartyList extends StatelessWidget {

  final List<Party> partiesList = [
    Party("Party 1", DateTime.now(), "Plainfield", 50, "Description goes here"),
    Party("Party 2", DateTime.now(), "Naperville", 10, "Description goes here"),
    Party("Party 3", DateTime.now(), "Romeoville", 100, "Description goes here"),
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
              // ADD A NEW CARD ///////////////////////////////////
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
            itemBuilder: (BuildContext ctxt, int index) => buildPartyCard(ctxt, index),
          ),
        ),
      ),
    );
  }

  // Widget for the physical card ---------------------------------------------
  Widget buildPartyCard(BuildContext ctxt, int index) {
    final party = partiesList[index];
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(party.title, style: TextStyle(fontSize: 30.0)),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 6.0),
                child: Text("${DateFormat('dd/MM/yyyy').format(party.date)} @ ${DateFormat('hh:mm').format(party.date)}"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0, bottom: 12.0),
                child: Text(party.location),
              ),

              
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(party.description),
              ),
              
              Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(party.population.toString()),
                ],
              ),   
            ],
          ),
        )
      ),
    );
  }
}