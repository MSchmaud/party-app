import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/views/new_parties/title_view.dart';
import 'package:partyApp/widgets/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partyApp/models/party.dart';

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

  @override
  Widget build(BuildContext ctxt) {

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;
    final newParty = new Party("Party Title", DateTime.now(), "Location", 50, "Description", "Theme",);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Parties'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'New Party',
            onPressed: () {
              Navigator.push(
                ctxt,
                 MaterialPageRoute(builder: (ctxt) => NewPartyTitleView(party: newParty))
              );
            },
          ),
        ]
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: StreamBuilder(
            stream: getUsersPartiesStreamSnapshots(ctxt),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return const Text("Loading...");
              }
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext ctxt, int index) => buildPartyCard(ctxt, snapshot.data.documents[index]),
              );
            }
          ),
        ),
      ),
    );
  }

  // Stream to get data from firebase
  Stream<QuerySnapshot> getUsersPartiesStreamSnapshots(BuildContext ctxt) async* {
    final uid = await Provider.of(ctxt).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('parties').snapshots();
  }

  // Widget for the physical card ---------------------------------------------
  Widget buildPartyCard(BuildContext ctxt, DocumentSnapshot party) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(party['title'], style: TextStyle(fontSize: 30.0)),
              Text("Theme: " + party['theme'], style: TextStyle(fontSize: 22.0)),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 6.0),
                child: Text("${DateFormat('dd/MM/yyyy').format(party['date'].toDate())} @ ${DateFormat('hh:mm').format(party['date'].toDate())}"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0, bottom: 12.0),
                child: Text(party['location']),
              ),

              
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(party['description']),
              ),
              
              Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(party['attendance'].toString()),
                ],
              ),   
            ],
          ),
        )
      ),
    );
  }
}