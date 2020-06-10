import 'package:flutter/material.dart';
import 'package:partyApp/models/party.dart';
import 'package:partyApp/views/new_parties/date_view.dart';

// Page for the location selection for a new party
class NewPartyLocationView extends StatelessWidget {
  final Party party;
  NewPartyLocationView({Key key, @required this.party}) : super(key: key);

  @override
  Widget build(BuildContext ctxt){

    TextEditingController _locationController = new TextEditingController();
    _locationController.text = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Party - Location'),
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(),
                ),
              ),
              RaisedButton(
                child: Text("Continue"),
                onPressed: () {
                  party.location = _locationController.text;
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => NewPartyDateView(party: party)),
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