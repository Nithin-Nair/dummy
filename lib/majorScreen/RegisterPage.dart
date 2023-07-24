import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Login/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmpasswordController = TextEditingController();
void signUserUp() async {
  showDialog(
      context: GlobalContextService.navigatorKey.currentContext!,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
  Future addUserDetails(String name, String email) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);
    final user =
        User(id: email, name: name, email: email,role:'guest');
    final json = user.toJson();
    await docUser.set(json);

  }

  if (passwordController.text == confirmpasswordController.text) {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), password: passwordController.text);
    addUserDetails(nameController.text.trim(),
         emailController.text.trim(),);
  }

  Navigator.pop(GlobalContextService.navigatorKey.currentContext!);

  Navigator.pushReplacement(GlobalContextService.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => LoginOrRegister()));
}

class _RegisterPageState extends State<RegisterPage> {
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
                    "Register",
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
                            controller: nameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        // Container(
                        //   decoration: const BoxDecoration(
                        //       border: Border(
                        //           bottom: BorderSide(color: Colors.grey))),
                        //   child: TextField(
                        //     controller: lastNameController,
                        //     decoration: InputDecoration(
                        //       border: InputBorder.none,
                        //       hintText: 'Last Name',
                        //       hintStyle: TextStyle(
                        //           color: Colors.grey[300],
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey,
                          ))),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold)),
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
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextField(
                            controller: confirmpasswordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
                                signUserUp();
                              },
                              child: const Text(
                                'Sign-up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )))),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login Now',
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

class User {
  String id;
  String name;
  String email;
  String role='user';
  User(
      {required this.id,
      required this.name,
      required this.email, required String role});
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email,'role':role};
}
