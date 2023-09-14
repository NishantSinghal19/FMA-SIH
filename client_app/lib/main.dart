import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client_app/routes/app_routes.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:client_app/services/localstorage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:client_app/services/token_regeneration_service.dart';

// TODO: Add stream controller
final _messageStreamController = BehaviorSubject<RemoteMessage>();

// TODO: Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 await Firebase.initializeApp();

 if (kDebugMode) {
   print("Handling a background message: ${message.messageId}");
   print('Message data: ${message.data}');
   print('Message notification: ${message.notification?.title}');
   print('Message notification: ${message.notification?.body}');
 }
}

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: Request permission
  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  // TODO: Register with FCM
  const vapidKey =
      "BBL_Pi_OJKP0JykT671IlSusR8_T19Iix0smxbS7MM3QxyB5whaQl2uYKC6d_3S1DJKEk_RYrk1u9wHUP5zKxPw";
  String? token;

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
    token = await messaging.getToken(
      vapidKey: vapidKey,
    );
  } else {
    token = await messaging.getToken();
  }

  if (kDebugMode) {
    print('Registration Token=$token');
  }

  // TODO: Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });

  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Loggy.initLoggy(logPrinter: const PrettyPrinter());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late Future<Map<String, dynamic>> _deviceData;
  var _isLoggedIn = false;
  String _lastMessage = "";

  _MyAppState() {
    _messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          _lastMessage = 'Received a notification message:'
              '\nTitle=${message.notification?.title},'
              '\nBody=${message.notification?.body},'
              '\nData=${message.data}';
        } else {
          _lastMessage = 'Received a data message: ${message.data}';
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getIsLoggedIn().then((isLoggedIn) {
      _isLoggedIn = isLoggedIn ?? false;
      // if (_isLoggedIn) {
      //   tokenExpirationHandler();
      // }
    });

    // _deviceData = getDeviceInfo(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
      ),
      title: 'Aplavankula ',
      debugShowCheckedModeBanner: false,
      initialRoute: _isLoggedIn
          ? AppRoutes.minePageContainerScreen
          : AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
