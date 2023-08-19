import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/majorScreen/eventsAndCells.dart';
import 'package:dummy/majorScreen/foodOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Login/login_or_register.dart';
class Event {
  final String imageUrl;
  final String eventName;
  final String location;

  Event(this.imageUrl, this.eventName, this.location);
}

class FoodStore {
  final String imageUrl;
  final String storeName;
  final String location;

  FoodStore(this.imageUrl, this.storeName, this.location);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Event> events = [
    Event(
      'assets/edm.jpg',
      "New Year's Eve",
      'Dhoom Ground',
    ),
    Event(
      'assets/d.jpg',
      "Dhoom Festival",
      'Dhoom Ground',
    ),
    Event(
      'assets/projection.jpg',
      "Projections 2024",
      'Dhoom Ground',
    ),
    Event(
      'assets/sem.jpg',
      "EDC Seminar",
      'Central Seminar Hall',
    ),
  ];

  // Sample list of FoodStore objects
  final List<FoodStore> foodStores = [
    FoodStore(
      'assets/chole.jpg',
      'Phonix food Store',
      'Old Food Court',
    ),
    FoodStore(
      'assets/waffle.jpeg',
      'The Belgian Waffle',
      'Near BBA Building',
    ),
    FoodStore(
      'assets/idli.jpg',
      'Mr. Idli',
      'New Food Court',
    ),
    FoodStore(
      'assets/shrirang.jpeg',
      'Shrirang Food Store',
      'Old Food Court',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        title: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid!)
                .get(),
            builder: (context, snapshot) {
              var uname=snapshot.data!['name'];
              return Text('Welcome ' + uname);

            }),
        backgroundColor: const Color(0xFF252525),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFE6EBEC),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // CircleAvatar(
                        //   radius: 30,
                        //   backgroundImage:
                        //   AssetImage('assets/profile_picture.png'),
                        // ),
                        // SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text(
                            //   'Welcome Back! 👋',
                            //   style: TextStyle(
                            //     fontFamily: 'Amethysta',
                            //     fontSize: 21,
                            //     fontWeight: FontWeight.bold,
                            //     color: Color(
                            //         0xFF7D7979), // #7D7979 color for text
                            //   ),
                            // ),
                            // Text(
                            //   'Soni Piyush',
                            //   style: TextStyle(
                            //     fontFamily: 'Amethysta',
                            //     fontSize: 18,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 16.0),
                    //   child: CircleAvatar(
                    //     radius: 25,
                    //     backgroundColor: Color.fromRGBO(255, 255, 255, 0.60),
                    //     backgroundImage: AssetImage('assets/img_1.png'),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20), // Add some vertical spacing
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0), // Add bottom padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Trending this week',
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 18,
                          color: Color(0xFF625D5D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0,right: 0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 175, // Height of the carousel item
                      autoPlay: true, // Enable auto-scrolling
                      enlargeCenterPage:
                      true, // Display one carousel item at a time
                      aspectRatio: 1.0, // Aspect ratio of the carousel item
                      autoPlayCurve: Curves
                          .fastOutSlowIn, // Animation curve for auto-scrolling
                      autoPlayInterval: Duration(
                          seconds: 5), // Time interval for auto-scrolling
                      autoPlayAnimationDuration: Duration(
                          milliseconds:
                          800), // Animation duration for auto-scrolling
                    ),
                    items: [
                      // List of carousel items
                      Container(
                        child: Image.asset(
                          'assets/images/home/img_5.png',
                          width: 400,
                          height: 200,
                        ),
                      ),
                      Container(
                        child: Image.asset(
                          'assets/images/home/img_5.png',
                          width: 400,
                          height: 200,
                        ),
                      ),
                      Container(
                        child: Image.asset(
                          'assets/images/home/img_5.png',
                          width: 400,
                          height: 200,
                        ),
                      ),
                      // Add more carousel items as needed
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0), // Add bottom padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF625D5D),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EventAndCells()));
                          },
                          child: Text(
                            'View More',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 8), // Add spacing between the text and the list
                Container(
                  height: 210,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: events.map((event) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 40.0), // Add spacing between events
                        child: EventCard(
                          imageUrl: event.imageUrl,
                          eventName: event.eventName,
                          location: event.location,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20), // Add some vertical spacing
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0), // Add bottom padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Popular Food Stores Nearby',
                        style: TextStyle(
                          fontFamily: 'Amethysta',
                          color: Color(0xFF625D5D),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodOrder()));
                          },
                          child: Text(
                            'View More',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 8), // Add spacing between the text and the list
                Container(
                  height: 210,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: foodStores.map((store) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 40.0), // Add spacing between food stores
                        child: FoodStoreCard(
                          imageUrl: store.imageUrl,
                          storeName: store.storeName,
                          location: store.location,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }





}

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String eventName;
  final String location;

  EventCard(
      {required this.imageUrl,
        required this.eventName,
        required this.location});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 251,
      height: 203,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 251,
                height: 143,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Amethysta',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(location),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20, // Adjust the bottom offset as needed
            right: 18, // Adjust the right offset as needed
            child: Image.asset(
              'assets/images/home/img.png', // Replace with your icon path
              width: 35,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }
}
class FoodStoreCard extends StatelessWidget {
  final String imageUrl;
  final String storeName;
  final String location;

  FoodStoreCard(
      {required this.imageUrl,
        required this.storeName,
        required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 251,
      height: 203,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 251,
                height: 143,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Amethysta',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(location),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20, // Adjust the bottom offset as needed
            right: 18, // Adjust the right offset as needed
            child: Image.asset(
              'assets/images/home/img.png', // Replace with your icon path
              width: 35,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarouselItem(String imageUrl) {
    return Stack(
      children: [
        Image.asset(imageUrl, fit: BoxFit.cover),
        Positioned(
          bottom: 16,
          right: 16,
          child: Image.asset(
            'assets/images/home/img_4.png',
            width: 35,
            height: 35,
          ),
        ),
      ],
    );
  }
}