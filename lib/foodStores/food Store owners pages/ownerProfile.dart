import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Login/login_or_register.dart';


class OwnerProfileScreen extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  OwnerProfileScreen({Key? key, }) :
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong!!');
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text('Document doesn\'t exists.');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String,dynamic> data=snapshot.data!.data() as Map<String,dynamic>;


            return Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Stack(children: [
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black26, Color(0xff252525)])),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      expandedHeight: 150,
                      flexibleSpace:
                      LayoutBuilder(builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            curve: Curves.bounceIn,
                            duration: const Duration(milliseconds: 200),
                            opacity: constraints.biggest.height <= 120 ? 1 : 0,
                            child: const Text(
                              'Account',
                              style:
                              TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                          background: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.black26, Color(0xff252525)])),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      radius: 50,
                                      backgroundImage:NetworkImage(data['profile_image'])
                                    // AssetImage(
                                    //     'assets/images/inapp/guest.jpg'),
                                    // backgroundColor: Colors.white,
                                  ),
                                  SizedBox(width: 20,),
                                  Text(
                                    data['name']==null?'username':data['name'],
                                    style: TextStyle(fontSize: 24,color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // Container(
                          //   width: MediaQuery.of(context).size.width * .90,
                          //   height: 80,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       color: Colors.white),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       Container(
                          //         width: MediaQuery.of(context).size.width * .2,
                          //         height: 60,
                          //         decoration: const BoxDecoration(
                          //           color: Colors.black54,
                          //           borderRadius: BorderRadius.only(
                          //             topLeft: Radius.circular(30),
                          //             bottomLeft: Radius.circular(30),
                          //           ),
                          //         ),
                          //         child: const Center(
                          //             child: Text(
                          //               'Cart',
                          //               style: TextStyle(
                          //                   fontSize: 20, color: Colors.yellow),
                          //             )),
                          //       ),
                          //       Container(
                          //         width: MediaQuery.of(context).size.width * .2,
                          //         height: 60,
                          //         decoration: const BoxDecoration(
                          //           color: Colors.yellow,
                          //           // borderRadius: BorderRadius.only(
                          //           //   topLeft: Radius.circular(20),
                          //           //   bottomLeft: Radius.circular(20),
                          //           // ),
                          //         ),
                          //         child: const Center(
                          //             child: Text(
                          //               'Orders',
                          //               style: TextStyle(fontSize: 20),
                          //             )),
                          //       ),
                          //       Container(
                          //         width: MediaQuery.of(context).size.width * .2,
                          //         height: 60,
                          //         decoration: const BoxDecoration(
                          //           color: Colors.black54,
                          //           borderRadius: BorderRadius.only(
                          //             topRight: Radius.circular(30),
                          //             bottomRight: Radius.circular(30),
                          //           ),
                          //         ),
                          //         child: const Center(
                          //             child: Text(
                          //               'Wishlist',
                          //               style: TextStyle(
                          //                   fontSize: 20, color: Colors.yellow),
                          //             )),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Container(
                            color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                const ProfileHeaderLabel(
                                  label: ' Account Info. ',
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 260,
                                    // width
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        RepeatedListTile(
                                          title: 'Email',
                                          subtitle:
                                          data['email'],
                                          icon: Icons.email_outlined,
                                        ),
                                        YellowDivider(),
                                        RepeatedListTile(
                                            title: 'Location',
                                            subtitle: data['address'],
                                            icon: Icons.home),
                                        YellowDivider(),
                                        RepeatedListTile(
                                            title: 'Phone no.',
                                            subtitle: data['phone'],
                                            icon: Icons.phone)
                                      ],
                                    ),
                                  ),
                                ),
                                const ProfileHeaderLabel(
                                    label: 'Account Settings '),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: 260,
                                    // width
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        RepeatedListTile(
                                          title: 'Edit Profile',
                                          onpressed: () {},
                                          icon: Icons.edit,
                                        ),
                                        const YellowDivider(),
                                        RepeatedListTile(
                                            title: 'Change Password',
                                            onpressed: () {},
                                            icon: Icons.lock_open_rounded),
                                        const YellowDivider(),
                                        RepeatedListTile(
                                            title: 'Log out',
                                            onpressed: () async {
                                              await GoogleSignIn().signOut();
                                              FirebaseAuth.instance.signOut();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginOrRegister()));
                                            },
                                            icon: Icons.logout_rounded)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            );
          }
          return Center(child: const CircularProgressIndicator(color: Color(0xff252525),));
        });
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String label;
  const ProfileHeaderLabel({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            width: 50,
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onpressed;

  const RepeatedListTile(
      {super.key,
        required this.title,
        this.subtitle = '',
        required this.icon,
        this.onpressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        thickness: 1,
        color: Colors.yellow,
      ),
    );
  }
}
