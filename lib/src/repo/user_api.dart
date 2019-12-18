import 'dart:convert';
import 'package:demo_app/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Function callback;

  UserApi(this.callback);

  Future<User> fetchPost() async {

    final response = await http.get('https://randomuser.me/api/0.4/?randomapi');

    this.callback();

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return  User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}