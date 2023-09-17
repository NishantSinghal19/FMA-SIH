import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serverUrl = dotenv.env['SERVER_URL'];

Future<void> registerDeviceResponse(Object? body) async {
  final response = await http.post(
    Uri.parse(serverUrl! + 'api/register_device'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 201) {
    print(response.body);
    if (jsonDecode(response.body)['message'] == 'Device already registered') {
      return;
    } else {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('deviceId', jsonDecode(response.body)['device']['_id']);
        prefs.setBool('isRegistered', true);
      });
    }
  } else if (response.statusCode == 422) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('deviceId', '');
    });
    throw ('Could not register device');
  } else {
    throw ('Network Error');
  }
}

Future<Map<String, dynamic>> getDeviceInfo(bool ifRegister) async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var deviceData = <String, dynamic>{};

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('firebaseToken') ?? '';
  final isRegistered = prefs.getBool('isRegistered') ?? false;

  try {
    if (Platform.isAndroid) {
      deviceData =
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo, token);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo, token);
    } else {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (ifRegister) {
      if (!isRegistered) {
        registerDeviceResponse(deviceData);
      }
    }
    return deviceData;
  } on PlatformException {
    deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    return deviceData;
  }
}

Map<String, dynamic> _readAndroidBuildData(
    AndroidDeviceInfo build, String token) {
  return <String, dynamic>{
    'softwareVersion': build.version.incremental,
    // 'os': build.version.baseOS,
    'model': build.model,
    'deviceType': 'android',
    'token': token,
    'os': 'test os version',
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data, String token) {
  return <String, dynamic>{
    'softwareVersion': data.systemVersion,
    'model': data.model,
    'os:': data.utsname.version,
    'deviceType': 'ios',
    'token': token,
  };
}
