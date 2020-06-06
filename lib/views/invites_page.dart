import 'package:flutter/material.dart';

class InvitesPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt){

    final _width = MediaQuery.of(ctxt).size.width;
    final _height = MediaQuery.of(ctxt).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invites'),
      ),
      body: Container(
        color: Theme.of(ctxt).backgroundColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              
              // EVERYTHING IN INVITES PAGE

            ],
          ),
        ),
      ),
    );
  }
}