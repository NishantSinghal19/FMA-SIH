import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setUserId(String id) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setString('userId', id);
  });
}

void setJWTtoken(String token) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setString('JWTtoken', token);
    SharedPreferences.getInstance().then((prefs) {
      logInfo(prefs.getString('JWTtoken'));
    });
  });
}

void setIsLoggedIn(bool flag) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setBool('isLoggedIn', flag);
  });
}

void setPhone(String phone) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setString('phone', phone);
  });
}

void setPassword(String pass) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setString('password', pass);
  });
}

void setTokenExpiryTime(int expiry) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setInt('tokenExpiryTime', expiry);
  });
}

void setTokenIssueTime(String issue) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setString('tokenIssueTime', issue);
  });
}

void setFirebaseToken(String token) async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.setString('firebaseToken', token);
  });
}

Future getUserId() async {
  await SharedPreferences.getInstance().then((prefs) {
    return prefs.getString('userId');
  });
}

Future getJWTtoken() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString('JWTtoken');
}

Future getIsLoggedIn() async {
  await SharedPreferences.getInstance().then((prefs) {
    return prefs.getBool('isLoggedIn');
  });
}

void clearUserId() async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.remove('userId');
  });
}

void clearIsLoggedIn() async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.remove('isLoggedIn');
  });
}

void clearJWTtoken() async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.remove('JWTtoken');
  });
}

void clearPhone() async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.remove('phone');
  });
}

void clearPassword() async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.remove('password');
  });
}

void clearAll() async {
  await SharedPreferences.getInstance().then((prefs) {
    prefs.clear();
  });
}
