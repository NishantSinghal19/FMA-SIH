import 'dart:async';
import 'dart:convert';

import 'package:client_app/core/models/stationData_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

var serverUrl = dotenv.env['SERVER_URL'];

Future<dynamic> raiseFloodSosCall(Object? body) async {
  final response =
      await http.post(Uri.parse(serverUrl! + 'api/raise_flood_sos'), body: body);

  if (response.statusCode == 200) {
    var list = jsonDecode(response.body)['data'] as List;
    return list.map((obj) => StationData.fromJson(obj));
  } else if (response.statusCode == 422) {
    throw ('Error fetching stations');
  } else {
    throw ('Network Error');
  }
}