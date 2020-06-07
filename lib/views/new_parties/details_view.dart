import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partyApp/models/party.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPartyDetailsView extends StatelessWidget {
  final db = Firestore.instance;
  final Party party;
  NewPartyDetailsView({Key key, @required this.party}) : super(key: key);

  @override
  Widget build(BuildContext ctxt){

    TextEditingController _attendanceController = new TextEditingController();
    //_attendanceController.text = party.population.toString();
    _attendanceController.text = "";
    TextEditingController _descriptionController = new TextEditingController();
    _descriptionController.text = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Party - Details'),
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter Expected Attendance*"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  controller: _attendanceController,
                  autofocus: true,
                ),
              ),
              Text("Enter a Description"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _descriptionController,
                  autofocus: true,
                  maxLines: null,
                ),
              ),
              Text("Title: ${party.title}"),
              Text("Theme: ${party.theme}"),
              Text("Location: ${party.location}"),
              Text("Date: ${party.date}"),
              Text("Attendance: ${party.population}"),
              Text("Description: ${party.description}"),
              RaisedButton(
                child: Text("Continue"),
                onPressed: () async {
                  // Save data to firebase
                  await db.collection("parties").add(party.toJson());

                  party.description = _descriptionController.text;
                  party.population = int.parse(_attendanceController.text);
                  Navigator.of(ctxt).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}