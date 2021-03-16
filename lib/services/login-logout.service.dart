import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<bool> doUserLogin({String username, String password}) async {
  final user = ParseUser(username, password, null);

  var response = await user.login();

  if (response.success) {
    return true;
  } else {
    return false;
  }
}

Future<bool> doUserRegistration(
    String username, String email, String password) async {
  final user = ParseUser.createUser(username, password, email);

  var response = await user.signUp();

  if (response.success) {
    return true;
  } else {
    return false;
  }
}
