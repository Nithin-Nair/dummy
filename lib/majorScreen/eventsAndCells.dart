import 'package:dummy/minor%20screens/searchbar.dart';
import 'package:flutter/material.dart';

import '../events and cells/description.dart';
import '../events and cells/streamEvents.dart';

class EventAndCells extends StatefulWidget {
  const EventAndCells({super.key});

  @override
  State<EventAndCells> createState() => _EventAndCellsState();
}

class _EventAndCellsState extends State<EventAndCells> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6ebec),
      appBar: AppBar(
        automaticallyImplyLeading:false ,
        backgroundColor: Color(0xff252525),
        elevation: 0,
        title: Center(
          child: FakeSearchBar(),
        ),
      ),
      body:  StreamEvent(),
    );
  }

}


