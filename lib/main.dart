import 'package:flutter/material.dart';
import 'package:mobile_banking/fingerprint_login_screen.dart';
import 'package:mobile_banking/home.dart';
import 'package:mobile_banking/password_login_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Mobile Banking',
    initialRoute: '/',
    theme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.amber
    ),
    routes: {
      '/': (context) => const Home(),
      '/password_login_screen': (context) => const PasswordLoginScreen(),
      '/fingerprint_login_screen': (context) => const FingerprintLoginScreen()
    },
  ),
  );
}