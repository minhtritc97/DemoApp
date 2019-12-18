import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocInforListTile extends StatelessWidget {
  String activeButton;
  DocumentSnapshot document;


  DocInforListTile(this.activeButton, this.document);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(
        activeButton == "Person"
            ? 'My name is'
            : (activeButton == "Place"
            ? 'I am from'
            : (activeButton == "Note"
            ? 'My email is'
            : (activeButton == "Phone"
            ? 'My phone is'
            : (activeButton == "Lock"
            ? ''
            : '')))),
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontWeight:
            FontWeight.w300),
      ),
      subtitle: new Text(
        activeButton == "Person"
            ? document['first'][0]
            .toUpperCase() +
            document['first']
                .substring(1) +
            ' ' +
            document['last'][0]
                .toUpperCase() +
            document['last']
                .substring(1)
            : (activeButton == "Place"
            ? document['city'][0]
            .toUpperCase() +
            document['city']
                .substring(1)
            : (activeButton == "Note"
            ? document[
        'email']
            : (activeButton == "Phone"
            ? document[
        'phone']
            : (activeButton == "Lock"
            ? document['username']

            : "")))),
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontWeight:
            FontWeight.w400,
            fontSize: 20.0),
      ),
    );

  }
}



