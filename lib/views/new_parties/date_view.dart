import 'package:flutter/material.dart';
import 'package:partyApp/models/party.dart';
import 'package:partyApp/views/new_parties/details_view.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:intl/intl.dart';

// View for selecting date of new party
class NewPartyDateView extends StatefulWidget {
  final Party party;
  NewPartyDateView({Key key, @required this.party}) : super(key: key);

  @override
  _NewPartyDateViewState createState() => _NewPartyDateViewState();
}

class _NewPartyDateViewState extends State<NewPartyDateView> {

  // Date variable for current date
  DateTime _date = DateTime.now();
  final DateFormat _formatter = new DateFormat('MM-dd-yyyy');

  // Displays the dateRange picker widget
  Future displayDateRangePicker(BuildContext ctxt) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
      context: ctxt,
      initialFirstDate: _date,
      initialLastDate: _date,
      firstDate: new DateTime(DateTime.now().year - 50),
      lastDate: new DateTime(DateTime.now().year + 50));
      if(picked != null) {
        setState(() {
          _date = picked[0];    // Sets the date to the selected date
        });
      }
  }

  @override
  Widget build(BuildContext ctxt){

    String _formatted = _formatter.format(_date); // Formats the date

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
              Text("Selected: $_formatted"),
              RaisedButton(
                child: Text("Select Date"),
                onPressed: () async {
                await displayDateRangePicker(ctxt);
              }),
              RaisedButton(
                child: Text("Continue"),
                onPressed: () {
                  widget.party.date = _date;
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => NewPartyDetailsView(party: widget.party)),
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