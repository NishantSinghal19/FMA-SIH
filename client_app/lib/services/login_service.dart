// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:client_app/services/localstorage_service.dart';

var serverUrl = dotenv.env['SERVER_URL'];

FutureOr<LoginResponse> loginService(
    String phone, BuildContext? currentContext) async {
  final response = await http.post(
    Uri.parse(serverUrl! + 'users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'phone': phone,
    }),
  );

  if (response.statusCode == 200) {
    setUserId(jsonDecode(response.body)['user']['_id']);
    setPhone(phone);
    setJWTtoken(jsonDecode(response.body)['token']);
    setTokenExpiryTime(jsonDecode(response.body)['totalTime']);
    setTokenIssueTime(DateTime.now().toString());
    return LoginResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422) {
    throw ('Invalid phone or password');
  } else {
    throw ('Network Error');
  }
}

class LoginResponse {
  final String phone;
  final String otp;
  final bool success;

  LoginResponse(
      {required this.phone, required this.otp, required this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      phone: json['user']['phone'],
      otp: json['otp'],
      success: json['success'],
    );
  }
}
