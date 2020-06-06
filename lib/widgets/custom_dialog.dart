import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, primaryButtonText, primaryButtonRoute, secondaryButtonText, secondaryButtonRoute;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.primaryButtonText,
    @required this.primaryButtonRoute,
    @required this.secondaryButtonText,
    @required this.secondaryButtonRoute,
  });

  @override
  Widget build(BuildContext ctxt){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.transparent,
      child: dialogContent(ctxt),
      elevation: 0.0,
    );
  }

  dialogContent(BuildContext ctxt){
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          // TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 16.0),

          // DESCRIPTION
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),

          SizedBox(height: 24.0),

          // PRIMARY BUTTON
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              color: Theme.of(ctxt).primaryColor,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
              onPressed: () {
                Navigator.pushNamed(ctxt, primaryButtonRoute);
              },
              child: Text(primaryButtonText, style: TextStyle(color: Colors.white)),
            ),
          ),

          // SECONDAY TEXT
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: () {
                Navigator.of(ctxt).pop();
              },
              child: Text(secondaryButtonText),
            ),
          ),

        ]
      ),
    );
  }
}