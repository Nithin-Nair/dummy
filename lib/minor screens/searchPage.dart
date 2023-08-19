import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back) ,color: Colors.black,onPressed: (){Navigator.of(context).pop();},),
        title: CupertinoSearchTextField(),elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}
