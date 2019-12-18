import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AsyncUserPicture extends StatelessWidget {
  AsyncSnapshot snapshot;

  AsyncUserPicture(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );

  }
}



