import 'package:flutter/material.dart';
import 'package:partyApp/models/party.dart';
import 'package:partyApp/views/new_parties/details_view.dart';

class NewPartyDateView extends StatelessWidget {
  final Party party;
  NewPartyDateView({Key key, @required this.party}) : super(key: key);

  @override
  Widget build(BuildContext ctxt){

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Party - Date'),
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter A Date*"),
              
              RaisedButton(
                child: Text("Continue"),
                onPressed: () {
                  party.date = DateTime.now();
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => NewPartyDetailsView(party: party)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}