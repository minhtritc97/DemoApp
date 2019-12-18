import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   GestureTapCallback onPressed;
   IconData icon;
    String activeButton;
    String style;
   CustomButton(this.onPressed, this.icon,this.activeButton,this.style);

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: new IconButton(
              icon: Icon(icon),
              onPressed: onPressed,
              iconSize: 32.0,
              color: activeButton == style ? Colors.green : Colors.grey,
            ),
          )
        ],
      );

  }
}