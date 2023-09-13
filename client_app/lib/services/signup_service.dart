// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

var serverUrl = dotenv.env['SERVER_URL'];

FutureOr<SignupResponse> createSignupResponse(
    String name,
    String email,
    String otp,
    BuildContext? currentContext) async {
  final response = await http.post(
    Uri.parse(serverUrl! + '/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'otp': otp,
    }),
  );

  if (response.statusCode == 201) {
    print(response.body);
    return SignupResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422) {
    throw ('Could not signup');
  } else {
    throw ('Network Error');
  }
}

class SignupResponse {
  final String email;
  final String activationToken;
  final String token;
  final bool success;

  SignupResponse(
      {required this.email,
      required this.activationToken,
      required this.token,
      required this.success});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      email: json['user']['email'],
      activationToken: json['user']['activationToken'],
      token: json['token'],
      success: json['success'],
    );
  }
}
