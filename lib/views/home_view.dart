import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext ctxt){
    return Scaffold(
      body:  Container(
        color: Theme.of(ctxt).backgroundColor,
        height: MediaQuery.of(ctxt).size.height,
        width: MediaQuery.of(ctxt).size.width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text("Home Page"),
            ]
          ),
        ),
      ),
    );
  }
}