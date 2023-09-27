import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../Login/login_or_register.dart';
import '../foodStores/orderScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!!'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text("Document doesn't exist."));
        }

        data = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          backgroundColor: Color(0xFFf2f2f2),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xff252525),
            title: Text(
              'My Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _uploadProfilePicture();
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                    CachedNetworkImageProvider(data['profile_image']),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  data['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  data['email'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24),
                ProfileSection(title: 'My Activity', children: [
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('My Orders'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.event),
                    title: Text('My Events'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Placeholder(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('My Locations'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Placeholder(),
                        ),
                      );
                    },
                  ),
                ]),
                SizedBox(height: 24),
                ProfileSection(
                  title: 'Account Info',
                  children: [
                    ProfileInfoItem(
                      icon: Icons.email,
                      label: 'Email',
                      value: data['email'],
                    ),
                    ProfileInfoItem(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: data['phone'] != '' ? data['phone'] : 'Not provided',
                    ),
                    ProfileInfoItem(
                      icon: Icons.location_on,
                      label: 'Location',
                      value: data['address'] != '' ? data['address'] : 'Not provided',
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ProfileSection(
                  title: 'Settings',
                  children: [
                    ProfileSettingsItem(
                      icon: Icons.lock,
                      label: 'Change Password',
                      onTap: () {
                        // Implement password change logic
                      },
                    ),
                    ProfileSettingsItem(
                      icon: Icons.logout,
                      label: 'Log Out',
                      onTap: () async {
                        await GoogleSignIn().signOut();
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginOrRegister(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _uploadProfilePicture() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageUrl = await _uploadImageToFirebaseStorage(File(pickedFile.path));

      if (imageUrl != null) {
        setState(() {
          data['profile_image'] = imageUrl;
        });

        // Update the user's profile picture in Firebase Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profile_image': imageUrl});
      }
    }
  }

  Future<String?> _uploadImageToFirebaseStorage(File file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('profile_images');
      final uploadTask = storageRef.putFile(file);
      final TaskSnapshot storageTaskSnapshot = await uploadTask;
      final imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  ProfileSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xff252525), // Icon color
      ),
      title: Text(
        label,
        style: TextStyle(
          color: Color(0xff252525), // Label color
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: Colors.grey, // Value color
        ),
      ),
    );
  }
}

class ProfileSettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  ProfileSettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xff252525), // Icon color
      ),
      title: Text(
        label,
        style: TextStyle(
          color: Color(0xff252525), // Label color
        ),
      ),
      onTap: onTap,
    );
  }
}
