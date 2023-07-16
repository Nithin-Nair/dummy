import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/next_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authorize.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
void signUserIn() async {
  showDialog(
      context: GlobalContextService.navigatorKey.currentContext!,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    Navigator.pop(GlobalContextService.navigatorKey.currentContext!);
    Navigator.pushReplacement(GlobalContextService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => NextPage()));
  } on FirebaseAuthException catch (e) {
    Navigator.pop(GlobalContextService.navigatorKey.currentContext!);
    if (e.code == 'user-not-found') {
      showDialog(
          context: GlobalContextService.navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: Text('User not Found'),
            );
          });
    } else if (e.code == 'wrong-password') {
      showDialog(
          context: GlobalContextService.navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: Text('Wrong Password'),
            );
          });
    }
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final widthof = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    height: 300,
                    width: widthof,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/background.png"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 300,
                      width: widthof + 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/background-2.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromRGBO(49, 39, 79, 1)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, 1),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey[300])),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Container(
                          height: 40,
                          width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(49, 39, 79, 1)),
                          child: TextButton(
                              onPressed: () async {
                                signUserIn();
                              },
                              child: const Text(
                                'Sign-in',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )))),
                  SizedBox(
                    height: 30,
                  ),

                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Center(
                  //     child: Container(
                  //         height: 40,
                  //         width: 250,
                  //         margin: const EdgeInsets.symmetric(horizontal: 60),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(50),
                  //             color: const Color.fromRGBO(49, 39, 79, 1)),
                  //         child: TextButton(
                  //             onPressed: () async {
                  //               WidgetsFlutterBinding.ensureInitialized();
                  //               await Firebase.initializeApp();
                  //              Authorize().signInWithGoogle();
                  //
                  //
                  //             },
                  //             child: const Text(
                  //               'Sign in with Google',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 15,
                  //               ),
                  //             )))),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Create a Guest Account',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
