import 'package:flutter/material.dart';
import 'src/screens/viewpage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Demo App', home: new ViewPage());
  }
}
