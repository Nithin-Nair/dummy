import 'package:dummy/majorScreen/foodOrder.dart';
import 'package:dummy/minor%20screens/userHomescreenBottomNavBar.dart';
import 'package:flutter/material.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6ebec),
      appBar: AppBar(centerTitle: true,
        automaticallyImplyLeading: false,
        title: const AppBarTitle(title: 'Cart'),
        elevation: 0,
        backgroundColor: Colors.black26,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your cart is empty!',
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              height: 50,
            ),
            Material(
              color: Color(0xff252525),
              borderRadius: BorderRadius.circular(25),
              child: MaterialButton(elevation: 0,minWidth: MediaQuery.of(context).size.width*.6,
                child: const Text('Go to Home',style: TextStyle(color: Colors.white,fontSize: 18),),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>userHomescreen()));
                },
              ),
            )
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
            child: Container(width: MediaQuery.of(context).size.width*.4,
              child: Row(
                children: const [
                  Text(
                    'Total:\$ ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '00.00',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xff252525), borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                onPressed: () {},
                child: const Text('Proceed to Payment',style: TextStyle(color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
class AppBarTitle extends StatelessWidget {
  final String title;
  const AppBarTitle({required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
        ));
  }
}