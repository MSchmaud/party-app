import 'package:flutter/material.dart';
import 'package:partyApp/models/party.dart';
import 'package:intl/intl.dart';
import 'package:partyApp/widgets/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Page that shows the party details and enables editing
class DetailPartyView extends StatefulWidget {
  final Party party;

  DetailPartyView({Key key, @required this.party}) : super(key: key);

  @override
  _DetailPartyViewState createState() => _DetailPartyViewState();
}

class _DetailPartyViewState extends State<DetailPartyView> {
  
  // All the variables and textcontrollers for editing fields
  var _title, _theme, _location, _date, _attendance, _description;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _themeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _attendanceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Initialize method
  void initState() {
    super.initState();
    _title = widget.party.title;
    _theme = widget.party.theme;
    _location = widget.party.location;
    _date = widget.party.date;
    _attendance = widget.party.population;
    _description = widget.party.description;
  }

  @override
  Widget build(BuildContext ctxt){
    return Scaffold(
      appBar: AppBar(
        title: Text("Party Details"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings), onPressed: () {
              _partyEditModalBottomSheet(ctxt);
            }),
        ],
      ),

      // Shows the information about the party
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: <Widget>[
                Text("Location: " + _location),
                Text("Title: " + _title),
                Text("Theme: " + _theme),
                Text("Date: " + DateFormat('MM/dd/yyyy').format(_date)),
                Text("Expected Attendance: " + _attendance.toString()),
                Text("Description: " + _description),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Popup for editing a party
  void _partyEditModalBottomSheet(ctxt) {

    // Sets the textfields initial values to what the data currently is
    _titleController.text = _title;
    _themeController.text = _theme;
    _locationController.text = _location;
    _attendanceController.text = _attendance.toString();
    _descriptionController.text = _description;

    // Actually shows the bottom sheet
    showModalBottomSheet(context: ctxt, builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(ctxt).size.height * 0.60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            // All the rows for textFields and buttons
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Edit Trip"),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.of(ctxt).pop();
                    }
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _themeController,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _attendanceController,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      widget.party.title = _titleController.text;       // Sets the local data to the textField data
                      widget.party.theme = _themeController.text;
                      widget.party.location = _locationController.text;
                      widget.party.population = int.parse(_attendanceController.text);
                      widget.party.description = _descriptionController.text;
                      setState(() {
                        _title = widget.party.title;
                        _theme = widget.party.theme;                    // Sets the data to be sent to firebase
                        _location = widget.party.location;
                        _attendance = widget.party.population;
                        _description = widget.party.description;
                      });
                      await updateParty(ctxt);  // Calls method to send data
                      Navigator.of(ctxt).pop();       
                    }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Delete'),
                    color: Colors.red,
                    onPressed: () async {
                      await deleteParty(ctxt);
                      Navigator.of(ctxt).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  // Method to send the data to firestore
  Future updateParty(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();  // Gets the uid
    final doc = Firestore.instance.collection('userData')       // Gets the doc instance from firebase
          .document(uid)
          .collection('parties')
          .document(widget.party.documentId);

    return await doc.setData(widget.party.toJson());            // Sets the data in firestore
  }

  // Method to delete a party
  Future deleteParty(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance.collection('userData')
          .document(uid)
          .collection('parties')                                // Does the same as update but just removes the doc
          .document(widget.party.documentId);

    return await doc.delete(); 
  }
}