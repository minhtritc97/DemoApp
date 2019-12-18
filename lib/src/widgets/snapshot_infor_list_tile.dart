
import 'package:flutter/material.dart';

class AsyncInforListTile extends StatelessWidget {
  String activeButton;
  AsyncSnapshot snapshot;


  AsyncInforListTile(this.activeButton, this.snapshot);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(
        activeButton == "Person"
            ? 'My name is'
            : ( activeButton == "Place"
            ? 'I am from'
            : ( activeButton == "Note"
            ? 'My email is'
            : ( activeButton == "Phone"
            ? 'My phone is'
            : ( activeButton == "Lock"
            ? ''
            : '')))),
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontWeight:
            FontWeight.w300),
      ),
      subtitle: new Text(
        activeButton == "Person"
            ? snapshot.data.first[0]
            .toUpperCase() +
            snapshot.data.first
                .substring(1) +
            ' ' +
            snapshot.data.last[0]
                .toUpperCase() +
            snapshot.data.last
                .substring(1)
            : ( activeButton == "Place"
            ? snapshot
            .data.city[0]
            .toUpperCase() +
            snapshot.data.city
                .substring(1)
            : ( activeButton == "Note"
            ? snapshot
            .data.email
            : ( activeButton == "Phone"
            ? snapshot
            .data
            .phone
            : ( activeButton == "Lock"
            ? snapshot
            .data
            .username
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



