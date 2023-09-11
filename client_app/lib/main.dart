import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client_app/routes/app_routes.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:client_app/services/localstorage_service.dart';
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
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // late Future<Map<String, dynamic>> _deviceData;
  var _isLoggedIn = false;
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
      title: 'client_app',
      debugShowCheckedModeBanner: false,
      initialRoute: _isLoggedIn ? AppRoutes.minePageContainerScreen : AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
