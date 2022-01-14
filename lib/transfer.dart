import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => TransferState();
}

class TransferState extends State<Transfer> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();


  @override
  void dispose() {
    accountNumberController.dispose();
    amountController.dispose();
    super.dispose();
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
      index: 3,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/account_state');
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/history');
        }
        if (index == 1) {
          Navigator.pushNamed(context, '/account_details');
        }
        //Handle button tap
      },), body: Padding(
      padding: const EdgeInsets.all(64.0),
      child: Column(
        children: [
          Text('Enter account number and amount to transfer.'),
          TextField(controller: accountNumberController),
          TextField(controller: amountController),
          OutlinedButton(child: Text('Confirm transfer'), onPressed: performTransfer,)]
      ),
    ));

  }

  void performTransfer() {
    http.post(Uri.parse('http://10.0.2.2:9001/users/0/transfer'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode({
          'accountNumber': accountNumberController.text,
          'amount': amountController.text
        }));
    Navigator.popAndPushNamed(context,'/account_state');  }
}
