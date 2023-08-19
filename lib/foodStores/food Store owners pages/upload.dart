import 'dart:ffi';

import 'package:dummy/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as fbs;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Login/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
class UploadNewItems extends StatefulWidget {
  // final Function()? onTap;
  const UploadNewItems({super.key,});

  @override
  State<UploadNewItems> createState() => _UploadNewItemsState();
}

class _UploadNewItemsState extends State<UploadNewItems> {
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  late String foodImage;
  late String foodName;
  late double foodPrice;
  late String itemId;
  late String pickedFoodImage;
  bool processing=false;


  CollectionReference users = FirebaseFirestore.instance.collection('users');

  XFile? imageFile;
  dynamic pickedImageError;
  void imagePicker() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFile = pickedImage!;
      });
    } catch (e) {
      setState(() {
        pickedImageError = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthof = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffe6ebec),
      body:SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          reverse: true,
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
              Center(
              child: GestureDetector(
              onTap: () {
        imagePicker();
        },
              child: CircleAvatar(
                backgroundImage: imageFile != null
                    ? FileImage(File(imageFile!.path))
                    :AssetImage('assets/images/click_here.jpg')  as ImageProvider,
                //,
                radius: 70,
              ),
        )),
      const SizedBox(
        height: 20,
      ),
      Column(
        children: [
              Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                child: TextFormField(

                  onChanged: (value){
                    foodName=value;
                  },

                  decoration: InputDecoration(

                      labelText: 'Food name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Enter food item name',
                      hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    foodPrice=double.parse(value);
                  },

                  decoration: InputDecoration(


                      labelText: 'Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Enter food price',
                      hintStyle: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.bold),),

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
                        onPressed: () {
                          uploadFoodItem();


                        },
                        child: processing==false?const Text(
                          'Upload item',
                          style: TextStyle(
                              color: Colors.white, fontSize: 15),
                        ):const Center(child: CircularProgressIndicator(),)))),
                ],
        ),]
    ),
            ),
          ),
    ),
    ),

    );
  }

  void uploadFoodItem() async{
    setState(() {
      processing=true;
    });
    fbs.Reference ref=fbs.FirebaseStorage.instance.ref('foodItems/${FirebaseAuth.instance.currentUser!.email}/${path.basename(imageFile!.path)}');

    await ref.putFile(File(imageFile!.path)).whenComplete(() async {
      pickedFoodImage=await ref.getDownloadURL();
    }).whenComplete(() async {
      CollectionReference foodItem=FirebaseFirestore.instance.collection('foodItems');
      itemId=Uuid().v4();
      await foodItem.doc(itemId).set({'item_id':itemId,'item_name':foodName,'item_price':foodPrice,'item_image':pickedFoodImage,'store_id':FirebaseAuth.instance.currentUser!.uid});
    }).whenComplete(() {
      setState(() {
        processing=false;
        imageFile=null;
        formKey.currentState?.reset();
      });
    });
  }
}