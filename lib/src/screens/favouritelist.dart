import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_app/src/widgets/custom_button.dart';
import 'package:demo_app/src/widgets/doc_user_picture.dart';
import 'package:demo_app/src/widgets/document_infor_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavouriteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FavouriteListState();
  }
}

class FavouriteListState extends State<FavouriteList> {

  String activeButton = "Person";


  @override
  Widget build(BuildContext context) {

    _onPressPerson(){
      setState(() {
        //isChecked ? true : false;
        activeButton = "Person";
      });
    }
    _onPressNote(){
      setState(() {
        //isChecked ? true : false;
        activeButton = "Note";
      });
    }
    _onPressPlace(){
      setState(() {
        //isChecked ? true : false;
        activeButton = "Place";
      });
    }
    _onPressPhone(){
      setState(() {
        //isChecked ? true : false;
        activeButton = "Phone";
      });
    }
    _onPressLock(){
      setState(() {
        //isChecked ? true : false;
        activeButton = "Lock";
      });
    }



    Widget fiveButtonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomButton(_onPressPerson,Icons.person,activeButton,"Person"),
          CustomButton(_onPressNote,Icons.event_note,activeButton,"Note"),
          CustomButton(_onPressPlace,Icons.map,activeButton,"Place"),
          CustomButton(_onPressPhone,Icons.phone,activeButton,"Phone"),
          CustomButton(_onPressLock,Icons.lock,activeButton,"Lock")
        ],
      ),
    );


    // TODO: implement build
    return Scaffold(
        body: new Container(
            child: new FutureBuilder<QuerySnapshot>(
                future:
                    Firestore.instance.collection('favourite').getDocuments(),

                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState != ConnectionState.done) {
                    // return: show loading widget
                  }
                  if (snapshot.hasError) {
                    // return: show error widget
                  }
                  return new PageView(

                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return new Container(
                        color: Color.fromARGB(100, 238, 235, 235),
                        padding: new EdgeInsets.only(top: 10.0),
                        child: new Center(
                          child: Column(
                            children: <Widget>[
                              new Container(
                                child: new Stack(
                                  alignment: const Alignment(0.0, 0.0),
                                  children: <Widget>[
                                    new Container(
                                      child: new SizedBox(
                                        height: 250.0,
                                        width: 350.0,
                                        child: new Card(
                                          child: new Column(
                                            children: <Widget>[
                                              new Container(
                                                child: new DocInforListTile(activeButton, document),
                                                padding: new EdgeInsets.only(
                                                    top: 60.0),
                                              ),
                                              fiveButtonSection
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    new DocUserPicture(document),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                })));
  }
}

class Favourite extends StatelessWidget {

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("Do you delete all?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Firestore.instance.collection('favourite').getDocuments().then((snapshot){
                  for (DocumentSnapshot ds in snapshot.documents){
                    ds.reference.delete();
                  }
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Favourite List"),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () => _showDialog(context))
        ],
      ),
      body: new FavouriteList(),
    );
  }
}
