
import 'package:dummy/foodStores/cart.dart';
import 'package:dummy/foodStores/streamingFoodItems.dart';
import 'package:dummy/foodStores/visitStores.dart';
import 'package:flutter/material.dart';

class FoodStoreItemPage extends StatefulWidget {
  final String fsname;
  final String image;
  final String storeId;

  const FoodStoreItemPage(
      {super.key, required this.fsname, required this.image, required this.storeId});

  @override
  State<FoodStoreItemPage> createState() => _FoodStoreItemPageState();
}

class _FoodStoreItemPageState extends State<FoodStoreItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6ebec),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: AppBar(
            elevation: 0,
            title: Center(child: Text(widget.fsname)),
            flexibleSpace: Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
            actions: [
              IconButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartScreen()));}, icon: Icon(Icons.shopping_cart))
            ],
          ),
        ),
      ),
      body: Container()
    );
  }

  Padding itemCard(BuildContext context,id,itemName,itemImage,itemPrice) {
    Map<dynamic, dynamic> count={};
    if (count.containsKey(id)==false){
      count[id]=0;
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.asset(
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
                              children: [Text(itemName,style: TextStyle(
                                  fontSize: 20))],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [Text('₹'+itemPrice,style: TextStyle(
                                  fontSize: 20))],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (count[id]<0) {
                                              count[id]= 0;
                                            }
                                            else{
                                              count[id]=count[id]!-1;
                                            }
                                          });
                                        },
                                        child: Container(
                                          child: const Text(
                                            '-',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          count[id].toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            count[id]++;
                                            print(count[id]);
                                          });
                                        },
                                        child: Container(
                                          child: Text(
                                            '+',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 35,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_shopping_cart_rounded,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
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
              ),
            ),
          );
  }
}
