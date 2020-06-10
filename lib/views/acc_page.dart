import 'package:flutter/material.dart';
import 'package:partyApp/services/auth_service.dart';
import 'package:partyApp/views/new_parties/title_view.dart';
import 'package:partyApp/widgets/provider.dart';
import 'package:partyApp/views/detail_party_view.dart';
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
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.undo),
          tooltip: 'Sign Out',
          onPressed: () async {
            try {
              AuthService auth = Provider.of(ctxt).auth;
              await auth.signOut();
            } catch (e){
              print(e);
            }
          }
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.dehaze),
            tooltip: 'Edit Profile',
            onPressed: () async {
              // TODO MAKE EDIT PROFILE PAGE
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(ctxt).backgroundColor,
          height: _height,
          width: _width,
          child: SafeArea(
            child: Column(
              children: <Widget>[

                // TODO DO ALL ACCOUNT STUFF
                // PLACE ALL ACOUNT INFO HERE

                FutureBuilder(
                  future: Provider.of(ctxt).auth.getCurrentUser(),
                  builder: (ctxt, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {
                      return displayUserInformation(ctxt, snapshot);
                    }else {
                      return CircularProgressIndicator();
                    }
                  }
                ),

                // Goes to parties list
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
      ),
    );
  }

  // Displays the user information
  Widget displayUserInformation(ctxt, snapshot) {
    final user = snapshot.data;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${user.displayName}", style: TextStyle(fontSize: 20)),
        ),
      ]
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

      // Container for the listview of user's parties
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
  Widget buildPartyCard(BuildContext ctxt, DocumentSnapshot document) {
    final party = Party.fromSnapshot(document);

    return Container(
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(document['title'], style: TextStyle(fontSize: 30.0)),
                Text("Theme: " + document['theme'], style: TextStyle(fontSize: 22.0)),
                Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 6.0),
                  child: Text("${DateFormat('dd/MM/yyyy').format(document['date'].toDate())} @ ${DateFormat('hh:mm').format(document['date'].toDate())}"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0, bottom: 12.0),
                  child: Text(document['location']),
                ),

                
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(document['description']),
                ),
                
                Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(document['attendance'].toString()),
                  ],
                ),   
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              ctxt,
              MaterialPageRoute(builder: (ctxt) => DetailPartyView(party: party)),
            );
          }
        )
      ),
    );
  }
}