import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordLoginScreen extends StatefulWidget {
  const PasswordLoginScreen({Key? key}) : super(key: key);

  @override
  State<PasswordLoginScreen> createState() => PasswordLoginScreenState();
}

class PasswordLoginScreenState extends State<PasswordLoginScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  bool failed = false;

  @override
  Widget build(BuildContext context) {
    if (failed)
      {
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(64.0),
              child: Column(
                  children: [Center(child: Text('Enter your login and PIN.')),
                    TextField(obscureText: false,controller: usernameController,),
                    TextField(obscureText: true, keyboardType: TextInputType.number, controller: pinController,),
                    Padding(
                      padding: const EdgeInsets.all(64.0),
                      child: OutlinedButton(child: Text('Accept',textAlign: TextAlign.center), onPressed: checkCredentials,),
                    ), Text('Invalid credentials.')]),
            )
        );
      }

    else{
      return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Column(
                children: [Center(child: Text('Enter your login and PIN.')),
                  TextField(obscureText: false,controller: usernameController,),
                  TextField(obscureText: true, keyboardType: TextInputType.number, controller: pinController,),
                  Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: OutlinedButton(child: Text('Accept',textAlign: TextAlign.center), onPressed: checkCredentials,),
                  )]),
          )
      );
    }

  }

  @override
  void dispose() {
    usernameController.dispose();
    pinController.dispose();
    super.dispose();
  }

  void checkCredentials() async {
    final response = await http.post(Uri.parse('http://10.0.2.2:9001/users/0'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
         body: jsonEncode({
      'login': usernameController.text,
      'pin': pinController.text
    }));

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/account_state');
    }

    else
    {
      setState(() {
        failed = true;
      });
    }
  }
}