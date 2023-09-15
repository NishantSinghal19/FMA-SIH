import 'package:client_app/core/models/notification_model.dart';
import 'package:client_app/core/notifications/notification.dart';
import 'package:client_app/services/registerDevice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client_app/routes/app_routes.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:client_app/services/localstorage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:client_app/services/token_regeneration_service.dart';

void main() async {
  await init();
  runApp(MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".env");
  Loggy.initLoggy(logPrinter: const PrettyPrinter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Map<String, dynamic>> _deviceData;
  var _isLoggedIn = false;
  var notificationModel = NotificationModel('', '', '');

  @override
  void initState() {
    super.initState();

    getIsLoggedIn().then((isLoggedIn) {
      _isLoggedIn = isLoggedIn ?? false;
      // if (_isLoggedIn) {
      //   tokenExpirationHandler();
      // }
    });

    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen((msg) {
      setState(() {
        if(msg.isNotEmpty) {
          notificationModel.data = msg;
        }
      });
    });
    firebaseMessaging.bodyCtlr.stream.listen((msg) {
      setState(() {
        if(msg.isNotEmpty) {
          notificationModel.body = msg;
        }
      });
    });
    firebaseMessaging.titleCtlr.stream.listen((msg) {
      setState(() {
        if(msg.isNotEmpty) {
          notificationModel.title = msg;
        }
      });
    });

    _deviceData = getDeviceInfo(true);
  }

  // _changeData(String msg) => setState(() => notificationModel.data = msg);
  // _changeBody(String msg) => setState(() => notificationModel.body = msg);
  // _changeTitle(String msg) => setState(() => notificationModel.title = msg);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _deviceData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              theme: ThemeData(
                visualDensity: VisualDensity.standard,
              ),
              title: 'Aplavankula',
              debugShowCheckedModeBanner: false,
              initialRoute: _isLoggedIn
                  ? AppRoutes.minePageContainerScreen
                  : AppRoutes.splashScreen,
              routes: AppRoutes.routes,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
