import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Carousel.dart';
import 'Carousel2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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

class _HomeScreenState extends State<HomeScreen> {
  late User? user; // To store the current user
  String? profileImageUrl;
  String? profileName;

  @override
  void initState() {
    super.initState();
    // Fetch the current user from Firebase Authentication
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch user data from Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data();
          setState(() {
            profileImageUrl = userData?['profile_image'];
            profileName = userData?['name'];
          });
        }
      });
    }
  }

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
      body: Container(
        color: Color(0xFFE6EBEC),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 16.0),
            // const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              CachedNetworkImageProvider(profileImageUrl ?? ''),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Welcome Back! 👋',
                              style: TextStyle(
                                fontFamily: 'Amethysta',
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7D7979),
                              ),
                            ),
                            Text(
                              profileName ?? '',
                              style: TextStyle(
                                fontFamily: 'Amethysta',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.60),
                        backgroundImage: AssetImage('assets/img_1.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add some vertical spacing
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0), // Add bottom padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Trending this month',
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
                  padding: const EdgeInsets.only(bottom: 0.0, right: 0),
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
                      GestureDetector(
                        child: Container(
                          child: Image.asset(
                            'assets/ganesha.png',
                            width: 400,
                            height: 200,
                          ),
                        ),
                        onTap: () {
                          // Navigate to Carousel.dart screen
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Carousel()));
                        },
                      ),

                      Container(
                        child: Image.asset(
                          'assets/img_6.png',
                          width: 400,
                          height: 200,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Image.asset(
                            'assets/img_7.png',
                            width: 400,
                            height: 200,
                          ),
                        ),
                        onTap: () {
                          // Navigate to Carousel.dart screen
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Carousel2()));
                        },
                      ),
                      // Add more carousel items as needed
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0), // Add bottom padding
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
                        child: Text(
                          'View More',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
                  padding:
                      const EdgeInsets.only(bottom: 8.0), // Add bottom padding
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
                        child: Text(
                          'View More',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
