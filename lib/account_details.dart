import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => AccountDetailsState();
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

Future<String> fetchAccountNumber() async {
final response = await http.get(Uri.parse('http://10.0.2.2:9001/users/0'));
if (response.statusCode == 200) {
// If the server did return a 200 OK response,
// then parse the JSON.
final json = jsonDecode(response.body);
return json['accountNumber'].toString();
} else {
// If the server did not return a 200 OK response,
// then throw an exception.
throw Exception('Failed to load account number');
}
}

class AccountDetailsState extends State<AccountDetails> {

  late Future<String> fullName;
  late Future<int> balance;
  late Future<String> accountNumber;

  @override
  void initState() {
    super.initState();
    fullName = fetchFullName();
    balance = fetchBalance();
    accountNumber = fetchAccountNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false), bottomNavigationBar: CurvedNavigationBar(
      color: Colors.black,
      backgroundColor: Colors.amber,
      items: <Widget>[
        Icon(Icons.circle, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.compare_arrows, size: 30),
      ],
        index: 1,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/account_state');
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/history');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/transfer');
        }
        //Handle button tap
      },),body: Column(
        children: <Widget>[
    FutureBuilder<String>(future: fullName, builder: (context, snapshot) {
    if (snapshot.hasData) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(child: Text('Owner of account: ' + snapshot.data!)),
    );
    } else if (snapshot.hasError) {
    return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
    },
    ),

          FutureBuilder<int>(future: balance, builder: (context, snapshot) {
    if (snapshot.hasData) {
    return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Center(child: Text('Account balance: ' + '${snapshot.data!}' + ' zł')),
    );
    } else if (snapshot.hasError) {
    return Text('${snapshot.error}');
    }

    return const CircularProgressIndicator();
          },
          ),



          FutureBuilder<String>(future: accountNumber, builder: (context, snapshot) {
    if (snapshot.hasData) {
    return Padding(
    padding: const EdgeInsets.all(32.0),
    child: Center(child: Text('Account number: ' + '${snapshot.data!}')),
    );
    } else if (snapshot.hasError) {
    return Text('${snapshot.error}');
    }

    return const CircularProgressIndicator();
    })
        ,OutlinedButton(child: Text('Transfer'), onPressed: change,)]
    ));

  }

  void change() {
    Navigator.pushNamed(context, '/transfer').then((_) {
      setState(() {
      });});
  }
}