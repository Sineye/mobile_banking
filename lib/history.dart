import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => HistoryState();
}


class HistoryState extends State<History> {
  late List<String> items = List.filled(100, '');
  @override
  Widget build(BuildContext context) {
    for (int index = 0; index < 100; ++index) {
      Random random = Random();
      String plusminus = index % 2 == 0 ? '+' : '-';
      items[index] = 'Transaction ${index}: ${plusminus}${random.nextInt(100)} zł;';
    }
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false), bottomNavigationBar: CurvedNavigationBar(
      color: Colors.black,
      backgroundColor: Colors.amber,
      items: <Widget>[
        Icon(Icons.circle, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.compare_arrows, size: 30),
      ],
      index: 2,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/account_state');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/transfer');
        }
        if (index == 1) {
          Navigator.pushNamed(context, '/account_details');
        }
        //Handle button tap
      },), body: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text(items[index]),
    );
    },
    ));
  }
}
