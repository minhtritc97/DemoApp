import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class DatabaseService {
  final CollectionReference collectionReference = Firestore.instance.collection('favourite');

  Future writeDB(User user) async {
    return await collectionReference.document(user.username).setData(user.toJson()).catchError((e) {
      print(e);
    });
  }


}

