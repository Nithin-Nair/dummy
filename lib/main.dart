
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Login/Authpage.dart';
import 'package:dummy/foodStores/providers/cart_provider.dart';
import 'package:dummy/minor%20screens/splash.dart';
import 'package:dummy/minor%20screens/userHomescreenBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // List<Map<String, dynamic>> cellData = [
  //   {
  //     'cellContact': '123456789',
  //     'cellDescription': 'xyz',
  //     'cellName': 'EDC',
  //     'cellImage': 'https://firebasestorage.googleapis.com/v0/b/dummy-proj-221a5.appspot.com/o/foodStores%2Fcr%40gmail.com%2Fcr.jpg?alt=media&token=e88fd78d-a80a-43f7-a8e5-742bdb431e25',
  //     'cellLocation': 'BBA Building',
  //     'cellWebsite': 'https://edc.paruluniversity.ac.in/',
  //     // Replace with the desired user_id
  //   },
  //
  //
  //   // Add more user data as needed
  // ];
  //
  // // Add each user data as a document with user_id as the document name
  // for (var cellData in cellData) {// Get the user_id
  //   await firestore.collection('Cell').doc().set(cellData);
  // }
  //
  // print('Documents added to Firestore with user_id as document name successfully.');


  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_)=>Cart())]
  ,child: const MyApp()));
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
      home:const Splash(),
    );
  }
}

class GlobalContextService {
  static GlobalKey <NavigatorState> navigatorKey =
  GlobalKey <NavigatorState> ();
}
