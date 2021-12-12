import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountState extends StatefulWidget {
  const AccountState({Key? key}) : super(key: key);

  @override
  State<AccountState> createState() => AccountStateState();
}

Future<String> fetchFullName() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:9001/users/0/'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final json = jsonDecode(response.body);
    return json['fullName'].toString();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load full name');
  }
}

Future<int> fetchBalance() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:9001/users/0/'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final json = jsonDecode(response.body);
    return json['balance'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load account balance');
  }
}

class AccountStateState extends State<AccountState> {

  late Future<String> fullName;
  late Future<int> balance;

  @override
  void initState() {
    super.initState();
    fullName = fetchFullName();
    balance = fetchBalance();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false),
    bottomNavigationBar: CurvedNavigationBar(
      color: Colors.black,
    backgroundColor: Colors.amber,
    items: <Widget>[
      Icon(Icons.circle, size: 30),
    Icon(Icons.add, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.compare_arrows, size: 30),
    ],
    index: 0,
    onTap: (index) {
        if (index == 1) {
          Navigator.pushNamed(context, '/account_details');
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/history');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/transfer');
        }
    //Handle button tap
    },),

    body: Column(children: [Padding(
            padding: const EdgeInsets.all(64.0),
            child: Center(
              child: FutureBuilder<String>(future: fullName, builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Welcome, ' + snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
              ),
            ),
          )
      ,OutlinedButton(
                style: ElevatedButton.styleFrom(shape: CircleBorder(), minimumSize: Size(200, 200)),
                onPressed: () { Navigator.pushNamed(context, '/account_details');},
                child: FutureBuilder<int>(future: balance, builder: (context, snapshot) {
    if (snapshot.hasData) {
    return Text('${snapshot.data!}' + ' zł');
    } else if (snapshot.hasError) {
    return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
    },
            ),), Padding(
              padding: const EdgeInsets.all(64.0),
              child: OutlinedButton(
                  style: ElevatedButton.styleFrom(shape: CircleBorder(), minimumSize: Size(200, 200)),
                  onPressed: () { Navigator.pushNamed(context, '/history').then((_) {
                    setState(() {
                    });});},
                  child: Text('History',textAlign: TextAlign.center)
              ),
            ),]));
  }
}