import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final String name = 'Ganesh Chaturthi';
  final String eimage = 'assets/ganesha.png'; // Assuming the image is in the 'assets' directory
  final String eventDescription = 'Ganesh Chaturthi is a Hindu festival that celebrates the birth of Lord Ganesha, the god of wisdom and prosperity. It is one of the most popular Hindu festivals, celebrated by millions of people around the world.';
  final int edate = 1;
  final String emonth = ' October';
  final String elocation = 'Football Ground';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6ebec),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Stack(
          children: [
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 20),
          child: Column(
            children: [
              // Remove the ClipRRect widget from the Row widget containing the image
              Row(
                children: [
                  Image.asset(
                    eimage,
                    fit: BoxFit.cover,
                    height: 165,
                  ),
                ],
              ),
              Row(
                children: const [
                  Text(
                    'Event Details:',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      eventDescription,
                      style: TextStyle(
                        height: 1.5,
                        letterSpacing: 1.5,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Event Date: $edate$emonth',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Venue: $elocation',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Placeholder()));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
