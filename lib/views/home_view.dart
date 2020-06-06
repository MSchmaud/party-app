import 'package:flutter/material.dart';
import "package:partyApp/views/acc_page.dart";

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  int _currentIndex = 0;
  final List<Widget> _children = [
    AccountPage(),
    AccountPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext ctxt){
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text("Account"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.language),
            title: new Text('Swipe'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Invites")
          ),
        ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


// Sign out button
              //IconButton(
                //icon: Icon(Icons.undo),
                //onPressed: () async {
                  //try{
                    //AuthService auth = Provider.of(ctxt).auth;
                    //await auth.signOut();
                    //print("signed Out!");
                  //} catch (e){
                    //print(e);
                  //}
                //}
              //),