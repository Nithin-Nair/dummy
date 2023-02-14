import 'package:dummy/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_or_register.dart';

class NextPage extends StatefulWidget {

  @override
  State<NextPage> createState() => _NextPageState();
}


class _NextPageState extends State<NextPage> {
  // get name => FirebaseAuth.instance.currentUser!.displayName!;
  // get getImage => FirebaseAuth.instance.currentUser!.photoURL;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xFFFC4F4F),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: GNav(
            padding: EdgeInsets.all(8),
            backgroundColor: Color(0xFFFC4F4F),
            color: Colors.white,
            gap: 8,
            activeColor: Colors.red,
            tabBackgroundColor: Colors.amber,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),

              GButton(
                icon: Icons.event,
                text: 'Events',
              ),
              GButton(
                icon: Icons.food_bank_outlined,
                text: 'Food Order',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                print(MediaQuery.of(context).size.width);
              },
              icon: const Icon(Icons.power_settings_new))
        ],

        title: Text('Welcome ',),
        backgroundColor: Color(0xFFFC4F4F),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      // body: Container(margin: const EdgeInsets.all(50),child: CircleAvatar(radius: 100,backgroundImage: NetworkImage(getImage),)),
    );
  }
}
