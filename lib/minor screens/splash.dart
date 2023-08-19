import 'dart:async';
import 'package:dummy/minor%20screens/whichRoleHomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../Login/login_or_register.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? finalEmail;
  late VideoPlayerController _controller;
  // Future getValidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var obtainedEmail = sharedPreferences.getString('role');
  //   setState(() {
  //     print(obtainedEmail);
  //     finalEmail = obtainedEmail;
  //     print(finalEmail);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/ss.mp4');
    _controller.initialize().then(((value) {
    }));
    play();
  }

  void play() {
    _controller.play();
    Timer(const Duration(seconds: 2), (() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => finalEmail==null? LoginOrRegister():HomePage().UserHome(finalEmail))));
    }));
    // getValidationData().whenComplete(() async {
    //
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(
              color: Colors.amber,
            ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    ));
  }
}
