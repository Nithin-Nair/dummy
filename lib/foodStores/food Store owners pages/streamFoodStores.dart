import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../foodStoreItemPage.dart';
import '../visitStores.dart';

class StreamFoodStores extends StatefulWidget {
  const StreamFoodStores({super.key});

  @override
  State<StreamFoodStores> createState() => _StreamNewItemState();
}

class _StreamNewItemState extends State<StreamFoodStores> {
  final Stream<QuerySnapshot> itemStream =
  FirebaseFirestore.instance.collection('foodStores').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: itemStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs!.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return foodCard(context,data!['name'],data!['store_image'],data!['location'],data['user_id']);
              }).toList()
              ,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return Text('Something went wrong!!');
        });
  }
  GestureDetector foodCard(BuildContext context,storeName,storeImage,location,storeId) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitStore(storeId: storeId,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * .95,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              storeImage,
                              fit: BoxFit.cover,
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [Text(storeName,style: TextStyle(
                              fontSize: 20))],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(location)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
