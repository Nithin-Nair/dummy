import 'package:dummy/minor%20screens/searchbar.dart';
import 'package:flutter/material.dart';

import '../events and cells/description.dart';
import '../events and cells/streamCells.dart';
import '../events and cells/streamEvents.dart';

class EventAndCells extends StatefulWidget {
  const EventAndCells({super.key});

  @override
  State<EventAndCells> createState() => _EventAndCellsState();
}

class _EventAndCellsState extends State<EventAndCells> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Color(0xffe6ebec),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('PUCollegiFY'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Events'), // First tab label
              Tab(text: 'Cells'),  // Second tab label
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamEvent(), // First tab content
            StreamCell(),  // Second tab content
          ],
        ),
      ),
    );
  }

}


