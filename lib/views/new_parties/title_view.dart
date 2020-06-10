import 'package:flutter/material.dart';
import 'package:partyApp/models/party.dart';
import 'package:partyApp/views/new_parties/location_view.dart';

// Initial page when creating new party
// Lets user select title and theme
class NewPartyTitleView extends StatelessWidget {
  final Party party;
  NewPartyTitleView({Key key, @required this.party}) : super(key: key);

  @override
  Widget build(BuildContext ctxt){

    TextEditingController _titleController = new TextEditingController();
    _titleController.text = "";
    TextEditingController _themeController = new TextEditingController();
    _themeController.text = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Party - Title'),
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter A Title*"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController,
                  autofocus: true,
                ),
              ),
              Text("Enter A Theme"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _themeController,
                  autofocus: true,
                ),
              ),
              RaisedButton(
                child: Text("Continue"),
                onPressed: () {
                  party.title = _titleController.text;
                  party.theme = _themeController.text;
                  Navigator.push(ctxt,
                   MaterialPageRoute(builder: (ctxt) => NewPartyLocationView(party: party))
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