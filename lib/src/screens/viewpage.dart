import 'dart:convert';
import 'dart:io';
import 'package:demo_app/src/repo/user_api.dart';
import 'package:demo_app/src/widgets/async_user_picture.dart';
import 'package:demo_app/src/widgets/custom_button.dart';
import 'package:demo_app/src/widgets/loading_icon.dart';
import 'package:demo_app/src/widgets/snapshot_infor_list_tile.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/database.dart';
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
  bool isShow =true;
  String activeButton = "Person";
  DatabaseService dbService = new DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
    user = UserApi(isShowUser).fetchPost();
  }

  @override
  void didUpdateWidget(ViewPage oldWidget) {
    // TODO: implement didUpdateWidget
    user =  UserApi(isShowUser).fetchPost();
    super.didUpdateWidget(oldWidget);
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

  void isShowUser() {
    setState(() {
      isShow = true;
    });
  }

  @override
  Widget build(BuildContext context) {

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
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text("Carousel"),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.playlist_add_check),
              onPressed: () =>  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Favourite())))
        ],
      ),
      body: isConnect && isShow
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
                              activeButton = "Person";
                              user =  UserApi(isShowUser).fetchPost();
                              isShow = false; // don't show previous user when current user is loading
                            });
                          }
                          if (dr == DismissDirection.startToEnd) {
                              dbService.writeDB(snapshot.data);
                            setState(() {
                              activeButton = "Person";
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
                        background: LoadingIcon(),
                        secondaryBackground: LoadingIcon(),
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
                                              child: new AsyncInforListTile(activeButton,snapshot),
                                              padding: new EdgeInsets.only(
                                                  top: 60.0),
                                            ),
                                            fiveButtonSection
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  new AsyncUserPicture(snapshot),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            )
          : Center(child: LoadingIcon()),
    );
  }
}

