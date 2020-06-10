import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Model for the party data fields
class Party {
  String title;
  DateTime date;
  String location;
  int population;
  String description;
  String theme;
  String documentId;

  Party(this.title, this.date, this.location, this.population, this.description, this.theme);

  // Method maps the data to josn to send to firebase
  Map<String, dynamic> toJson() => {
    'title': title,
    'theme': theme,
    'date': date,
    'location': location,
    'attendance': population,
    'description': description,
  };

  // The fromsnapshot method to get the physical data
  Party.fromSnapshot(DocumentSnapshot snapshot) :
    title = snapshot['title'],
    theme = snapshot['theme'],
    date = snapshot['date'].toDate(),
    location = snapshot['location'],
    population = snapshot['attendance'],
    description = snapshot['description'],
    documentId = snapshot.documentID;

}