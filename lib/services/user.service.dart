import 'dart:convert';

import 'package:ensitapp/models/user.model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //singleton
  static final UserService _userService = UserService._internal();
  //static final String _instanceRef = "_User";

  factory UserService() {
    return _userService;
  }

  UserService._internal();
  // fin singleton

  Future<User> getCurrent() async {
    final ParseUser response = await ParseUser.currentUser();

    print("UserService 65 --" + response.toString());

    if (response != null) return User.fromParse(response);

    return null;
  }

  Future<bool> isCurrent(String userId) async {
    final ParseUser currentUser = await ParseUser.currentUser();
    if (currentUser.objectId == userId) {
      return true;
    } else
      return false;
  }
}
