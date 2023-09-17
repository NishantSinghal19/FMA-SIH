// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:client_app/core/models/stationData_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

var serverUrl = dotenv.env['SERVER_URL'];

Future<Iterable<StationData>> getStationListAboveWarning() async {
  final response = await http.get(Uri.parse(serverUrl! + 'api/get_station_above_warning'));

  if (response.statusCode == 200) {
    var list = jsonDecode(response.body)['data'] as List;
    return list.map((obj) => StationData.fromJson(obj));
  } else if (response.statusCode == 422) {
    throw ('Error fetching stations');
  } else {
    throw ('Network Error');
  }
}

Future<dynamic> getStationData(String id) async {
  final response = await http.get(Uri.parse('https://ffs.india-water.gov.in/iam/api/layer-station/' + id), headers: {
    'Class-Name' : 'ForecastDetailLayerStationDto'
  });

  if (response.body.isNotEmpty) {
    var resp = jsonDecode(response.body);
    var obj = {
      "district" : resp.districtId.name,
      "divisionalOffice": resp.divisionalOffice.name,
      "river": resp.river.name,
      "basin": resp.basin.name,
    };

    return obj;
  } else if (response.statusCode == 422) {
    throw ('Error fetching stations');
  } else {
    throw ('Network Error');
  }
}

Future<dynamic> getPresentWaterLevelData(String stationCode) async {
  final url = Uri.https(
    'ffs.india-water.gov.in',
    '/iam/api/new-entry-data/specification/sorted-page',
    {
      'specification': Uri.encodeComponent('{"where":{"where":{"expression":{"valueIsRelationField":false,"fieldName":"id.stationCode","operator":"eq","value":${stationCode}}} }}'),
    },
    // {
    //   'sort-criteria': Uri.encodeComponent('{"sortOrderDtos":[{"sortDirection":"DESC","field":"id.dataTime"}]}'),
    //   'page-number': '0',
    //   'page-size': '2',
    //   'specification': Uri.encodeComponent('{"where":{"where":{"expression":{"valueIsRelationField":false,"fieldName":"id.stationCode","operator":"eq","value":${stationCode}}},"and":{"expression":{"valueIsRelationField":false,"fieldName":"id.datatypeCode","operator":"eq","value":"HHS"}}},"and":{"expression":{"valueIsRelationField":false,"fieldName":"dataValue","operator":"null","value":"false"}}}'),
    // },
  );

  final response = await http.get(url, headers: {
    "Class-Name": 'NewEntryDataDto'
  });

  if (response.body.isNotEmpty) {
    var resp = jsonDecode(response.body)[0];
    var obj = {
      "presentLevel" : resp.dataValue,
      "lastNotedTime": resp.id.dataTime,
      "stationCode": resp.id.stationCode,
    };

    return obj;
  } else if (response.statusCode == 422) {
    throw ('Error fetching stations');
  } else {
    throw ('Network Error');
  }
}




