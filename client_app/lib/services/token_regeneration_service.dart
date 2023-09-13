// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:client_app/services/localstorage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serverUrl = dotenv.env['SERVER_URL'];

FutureOr<bool> checkTokenExpiration(SharedPreferences prefs) async {
  final String? tokenIssueTime = prefs.getString('tokenIssueTime') ?? "";
  final int? tokenExpirationTime = prefs.getInt('tokenExpiryTime') != 0
      ? prefs.getInt('tokenExpiryTime')
      : 0;

  final DateTime now = DateTime.now().toUtc();
  final DateTime expiry = DateTime.parse(tokenIssueTime!)
      .add(Duration(seconds: tokenExpirationTime!))
      .toUtc();
  if (expiry.isBefore(now)) {
    return true;
  }
  return false;
}

FutureOr<void> tokenRegeneration(SharedPreferences prefs) async {
  final String phone = prefs.getString('phone')!;
  final String password = prefs.getString('password')!;

  final response = await http.post(
    Uri.parse(serverUrl! + 'users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone': phone,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
    setJWTtoken(jsonDecode(response.body)['token']);
    setTokenExpiryTime(jsonDecode(response.body)['totalTime']);
    setTokenIssueTime(DateTime.now().toString());
  } else {
    // Scaffold.of(context!)
    //     .showSnackBar(SnackBar(content: Text('Authorization Failed')));
    throw ('Authorization Failed');
  }
}

FutureOr<void> tokenExpirationHandler() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('isLoggedIn') != true) {
    throw Exception('User is not logged in');
  }

  checkTokenExpiration(prefs).then((bool expired) {
    if (expired) {
      tokenRegeneration(prefs).then((value) {
        return value;
      });
    }
  });
}
