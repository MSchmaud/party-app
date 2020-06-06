import 'package:partyApp/services/auth_service.dart';
import 'package:flutter/material.dart';

// This widget alerts all child widgets that the state has changed
class Provider extends InheritedWidget {
  final AuthService auth;
  Provider({Key key, Widget child, this.auth,}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext ctxt) => (ctxt.dependOnInheritedWidgetOfExactType<Provider>());
}