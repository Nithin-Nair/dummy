// ignore_for_file: prefer_const_constructors
import 'package:dummy/Login/Authpage.dart';
import 'package:dummy/minor%20screens/splash.dart';
import 'package:dummy/minor%20screens/userHomescreenBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalContextService.navigatorKey,
      home:Splash(),
    );
  }
}

class GlobalContextService {
  static GlobalKey <NavigatorState> navigatorKey =
  GlobalKey <NavigatorState> ();
}
