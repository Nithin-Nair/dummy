import 'dart:async';
import 'package:dummy/next_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;



  @override
  void initState() {
    super.initState();
    
    _controller=VideoPlayerController.asset('assets/ss.mp4');
    _controller.initialize().then(((value) {
      setState(() {
        
      });
    }));
    play();
  }
  void play()
  {
    _controller.play();
    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => NextPage())));
    }));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _controller.value.isInitialized? AspectRatio(aspectRatio: _controller.value.aspectRatio,child: VideoPlayer(_controller),):Container(color: Colors.amber,),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

      )
    );
  }
}
