import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'database.dart';
import 'favouritelist.dart';
import 'package:http/http.dart' as http;

class ViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ViewPageState();
  }
}

class ViewPageState extends State<ViewPage> {
  Future<User> user;
  bool isConnect = false;
  bool isPerson = true;
  bool isNote = false;
  bool isPlace = false;
  bool isPhone = false;
  bool isLock = false;
  DatabaseService dbService = new DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
    user = fetchPost();
  }

  @override
  void didUpdateWidget(ViewPage oldWidget) {
    // TODO: implement didUpdateWidget
    user = fetchPost();
    super.didUpdateWidget(oldWidget);
  }

  Future<User> fetchPost() async {
    final response = await http.get('https://randomuser.me/api/0.4/?randomapi');
    setState(() {
      isConnect=true;
    });
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isConnect = true;
        });
        print('connected');
      }
    } on SocketException catch (_) {
      setState(() {
        isConnect = false;
      });
      print('not connected');
    }
  }

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
    final screenSize = MediaQuery.of(context).size;


    return new Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text("Carousel"),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.playlist_add_check),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Favourite())))
        ],
      ),
      body: isConnect
          ? new FutureBuilder<User>(
              future: user,
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
                return new Container(
                  color: Color.fromARGB(100, 238, 235, 235),
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Center(
                    child: Dismissible(
                        key: UniqueKey(),
                        crossAxisEndOffset: 0.3,
                        onDismissed: (DismissDirection dr) {
                          if (dr == DismissDirection.endToStart) {
                            //next page
                            setState(() {
                              isPerson = true;
                              isNote = false;
                              isPlace = false;
                              isPhone = false;
                              isLock = false;
                              user = fetchPost();
                              isConnect=false;
                            });
                          }
                          if (dr == DismissDirection.startToEnd) {
                              dbService.writeDB(snapshot.data);
                            setState(() {
                              isPerson = true;
                              isNote = false;
                              isPlace = false;
                              isPhone = false;
                              isLock = false;
                            });

                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                duration: new Duration(seconds: 1),
                                content: Text("Added in favourite list"),
                              ),
                            );
                          }
                        },
                        direction: DismissDirection.horizontal,
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.all(5),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                        secondaryBackground: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.all(5),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                                      ? snapshot.data.first[0]
                                                              .toUpperCase() +
                                                          snapshot.data.first
                                                              .substring(1) +
                                                          ' ' +
                                                          snapshot.data.last[0]
                                                              .toUpperCase() +
                                                          snapshot.data.last
                                                              .substring(1)
                                                      : (isPlace
                                                          ? snapshot
                                                                  .data.city[0]
                                                                  .toUpperCase() +
                                                              snapshot.data.city
                                                                  .substring(1)
                                                          : (isNote
                                                              ? snapshot
                                                                  .data.email
                                                              : (isPhone
                                                                  ? snapshot
                                                                      .data
                                                                      .phone
                                                                  : (isLock
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
                                    padding: new EdgeInsets.only(bottom: 300.0),
                                    child: new ClipOval(
                                        child: new CachedNetworkImage(
                                      width: 150.0,
                                      height: 150.0,
                                      imageUrl: snapshot.data.picture,
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
                        )),
                  ),
                );
              },
            )
          : Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.all(5),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor:
                AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

