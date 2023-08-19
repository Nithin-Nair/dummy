import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/foodStores/visitStores.dart';
import 'package:dummy/majorScreen/foodOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyStore extends StatefulWidget {
  const MyStore({super.key});

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  CollectionReference store = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> itemStream = FirebaseFirestore.instance
      .collection('foodItems')
      .where('store_id', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: store.doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong!!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(child: Text('There are no food items!'));
            //   Scaffold(
            //   appBar: PreferredSize(
            //     preferredSize: Size.fromHeight(200),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(20),
            //           bottomRight: Radius.circular(20)),
            //       child: AppBar(
            //         elevation: 0,
            //         title: Center(child: Text(data['name'])),
            //         flexibleSpace: Image.network(data['profile_image'],
            //           fit: BoxFit.cover,
            //         ),
            //         actions: [
            //           IconButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartScreen()));}, icon: Icon(Icons.shopping_cart))
            //         ],
            //       ),
            //     ),
            //   ),
            //   body: ,
            // );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              backgroundColor: Color(0xffe6ebec),
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(200),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AppBar(
                        actions: [IconButton(onPressed: (){}, icon:Icon(Icons.edit))],
                        flexibleSpace: Image.network(
                          data['profile_image'],
                          fit: BoxFit.cover,
                        ),
                        centerTitle: true,
                        elevation: 1,
                        title: Text(data['name']),
                      ))),
              body: StreamBuilder<QuerySnapshot>(
                  stream: itemStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong!');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return itemCard(
                          context,
                          0,
                          data['item_name'],
                          data['item_image'],
                          data['item_price'].toString(),
                        );
                      }).toList(),
                    );
                  }),
            );
          }

          return Text('Loading');
        });
  }

  Padding itemCard(BuildContext context, id, itemName, itemImage, itemPrice) {
    Map<dynamic, dynamic> count = {};
    if (count.containsKey(id) == false) {
      count[id] = 0;
    }
    return Padding(
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            itemImage,
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
                        children: [
                          Text(itemName, style: TextStyle(fontSize: 20))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('₹' + itemPrice, style: TextStyle(fontSize: 20))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: 35,
                      //       width: 95,
                      //       decoration: BoxDecoration(
                      //           color: Colors.red,
                      //           borderRadius: BorderRadius.all(
                      //               Radius.circular(10))),
                      //       child: Row(
                      //         mainAxisAlignment:
                      //         MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           InkWell(
                      //             onTap: () {
                      //               setState(() {
                      //                 if (count[id]<0) {
                      //                   count[id]= 0;
                      //                 }
                      //                 else{
                      //                   count[id]=count[id]!-1;
                      //                 }
                      //               });
                      //             },
                      //             child: Container(
                      //               child: const Text(
                      //                 '-',
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 20),
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             child: Text(
                      //               count[id].toString(),
                      //               style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 20),
                      //             ),
                      //           ),
                      //           GestureDetector(
                      //             onTap: () {
                      //               setState(() {
                      //                 count[id]++;
                      //                 print(count[id]);
                      //               });
                      //             },
                      //             child: Container(
                      //               child: Text(
                      //                 '+',
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 20),
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Container(
                      //       height: 35,
                      //       width: 95,
                      //       decoration: BoxDecoration(
                      //           color: Colors.red,
                      //           borderRadius: BorderRadius.all(
                      //               Radius.circular(10))),
                      //       child: Row(
                      //         mainAxisAlignment:
                      //         MainAxisAlignment.center,
                      //         children: [
                      //           Icon(
                      //             Icons.add_shopping_cart_rounded,
                      //             color: Colors.white,
                      //           ),
                      //           Container(
                      //             child: Text(
                      //               'Add to cart',
                      //               style: TextStyle(
                      //                   color: Colors.white),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
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
