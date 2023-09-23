import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Orders'),
        backgroundColor: Color(0xff252525),
      ),
      backgroundColor: Color(0xffe6ebec),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('cust_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong!"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('There are no orders.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              return ItemOrderWidget(
                imageUrl: order['order_image'],
                itemName: order['order_name'],
                price: order['order_price'],
                quantity: order['order_qnt'],
                status: order['order_status'],
                orderTime: order['order_time'],
                orderCompleteTime: order['order_complete_time'],
                storeName: order['store_name'],
              );
            },
          );
        },
      ),
    );
  }
}

class ItemOrderWidget extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final double price;
  final int quantity;
  final String status;
  final Timestamp orderTime; // Change this to Timestamp
  final String orderCompleteTime;
  final String storeName;

  ItemOrderWidget({
    required this.imageUrl,
    required this.itemName,
    required this.price,
    required this.quantity,
    required this.status,
    required this.orderTime,
    required this.orderCompleteTime,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the Timestamp to DateTime
    DateTime orderDateTime = orderTime.toDate();

    // Format the DateTime using intl package
    String formattedOrderTime = DateFormat('MMMM dd, yyyy h:mm a').format(orderDateTime);

    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Store: $storeName',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl: imageUrl,
            width: double.infinity,
            height: 150.0,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Price: ₹$price | Quantity: $quantity',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Status: $status',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Order Time: $formattedOrderTime', // Use the formatted time here
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


