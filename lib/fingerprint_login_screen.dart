import 'package:flutter/material.dart';

class FingerprintLoginScreen extends StatelessWidget {
  const FingerprintLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Przyłóż palec do czytnika odcisków.')
    );
  }

}