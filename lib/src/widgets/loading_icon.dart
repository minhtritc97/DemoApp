import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );

  }
}



