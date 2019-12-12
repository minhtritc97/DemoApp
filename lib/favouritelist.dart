import 'package:cached_network_image/cached_network_image.dart';
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

  bool isPerson = true;
  bool isNote = false;
  bool isPlace = false;
  bool isPhone = false;
  bool isLock = false;


  @override
  Widget build(BuildContext context) {
    Widget buildButton1(IconData icon) {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: new IconButton(
              icon: Icon(icon),
              onPressed: () {
                setState(() {
                  //isChecked ? true : false;
                  isPerson = true;
                  isNote = false;
                  isPlace = false;
                  isPhone = false;
                  isLock = false;
                });
              },
              iconSize: 32.0,
              color: isPerson ? Colors.green : Colors.grey,
            ),
          )
        ],
      );
    }

    Widget buildButton2(IconData icon) {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: new IconButton(
              icon: Icon(icon),
              onPressed: () {
                setState(() {
                  isPerson = false;
                  isNote = true;
                  isPlace = false;
                  isPhone = false;
                  isLock = false;
                });
              },
              iconSize: 32.0,
              color: isNote ? Colors.green : Colors.grey,
            ),
          )
        ],
      );
    }

    Widget buildButton3(IconData icon) {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: new IconButton(
              icon: Icon(icon),
              onPressed: () {
                setState(() {
                  //isChecked ? true : false;
                  isPerson = false;
                  isNote = false;
                  isPlace = true;
                  isPhone = false;
                  isLock = false;
                });
              },
              iconSize: 32.0,
              color: isPlace ? Colors.green : Colors.grey,
            ),
          )
        ],
      );
    }

    Widget buildButton4(IconData icon) {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: new IconButton(
              icon: Icon(icon),
              onPressed: () {
                setState(() {
                  isPerson = false;
                  isNote = false;
                  isPlace = false;
                  isPhone = true;
                  isLock = false;
                });
              },
              iconSize: 32.0,
              color: isPhone ? Colors.green : Colors.grey,
            ),
          )
        ],
      );
    }

    Widget buildButton5(IconData icon) {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: new IconButton(
              icon: Icon(icon),
              onPressed: () {
                setState(() {
                  isPerson = false;
                  isNote = false;
                  isPlace = false;
                  isPhone = false;
                  isLock = true;
                });
              },
              iconSize: 32.0,
              color: isLock ? Colors.green : Colors.grey,
            ),
          )
        ],
      );
    }

    Widget fourButtonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton1(Icons.person),
          buildButton2(Icons.event_note),
          buildButton3(Icons.map),
          buildButton4(Icons.phone),
          buildButton5(Icons.lock)
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
                                                child: new ListTile(
                                                  title: new Text(
                                                    isPerson
                                                        ? 'My name is'
                                                        : (isPlace
                                                            ? 'I am from'
                                                            : (isNote
                                                                ? 'My email is'
                                                                : (isPhone
                                                                    ? 'My phone is'
                                                                    : (isLock
                                                                        ? ''
                                                                        : '')))),
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  subtitle: new Text(
                                                    isPerson
                                                        ? document['first'][0]
                                                        .toUpperCase() +
                                                        document['first']
                                                            .substring(1) +
                                                        ' ' +
                                                        document['last'][0]
                                                            .toUpperCase() +
                                                        document['last']
                                                            .substring(1)
                                                        : (isPlace
                                                            ? document['city'][0]
                                                        .toUpperCase() +
                                                        document['city']
                                                            .substring(1)
                                                            : (isNote
                                                                ? document[
                                                                    'email']
                                                                : (isPhone
                                                                    ? document[
                                                                        'phone']
                                                                    : (isLock
                                                                        ? document['username']

                                                                        : "")))),
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20.0),
                                                  ),
                                                ),
                                                padding: new EdgeInsets.only(
                                                    top: 60.0),
                                              ),
                                              fourButtonSection
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    new Container(
                                      padding:
                                          new EdgeInsets.only(bottom: 300.0),
                                      child: new ClipOval(
                                          child: new CachedNetworkImage(
                                        width: 150.0,
                                        height: 150.0,
                                        imageUrl: document['picture'],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )),
                                    ),
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
