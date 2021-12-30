import 'package:flutter/material.dart';
import 'package:mobile_banking/fingerprint_login_screen.dart';
import 'package:mobile_banking/home.dart';
import 'package:mobile_banking/password_login_screen.dart';
import 'package:mobile_banking/account_state.dart';
import 'package:mobile_banking/account_details.dart';
import 'package:mobile_banking/history.dart';
import 'package:mobile_banking/transfer.dart';

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
      '/fingerprint_login_screen': (context) => const FingerprintLoginScreen(),
      '/account_state': (context) => const AccountState(),
      '/history': (context) => const History(),
      '/account_details': (context) => const AccountDetails(),
      '/transfer': (context) => const Transfer()
    },
  ),
  );
}