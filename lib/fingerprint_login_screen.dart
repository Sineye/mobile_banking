import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintLoginScreen extends StatefulWidget {
  const FingerprintLoginScreen({Key? key}) : super(key: key);

  @override
  State<FingerprintLoginScreen> createState() => FingerprintLoginScreenState();
}

class FingerprintLoginScreenState extends State<FingerprintLoginScreen> {

  final LocalAuthentication localAuthentication = LocalAuthentication();

  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    return canCheckBiometrics;
  }

  Future<void> _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await localAuthentication.authenticate(
        biometricOnly: true,
        localizedReason: "Authenticate", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
      if (authenticated)
      {
        Navigator.pushReplacementNamed(context, '/account_state');
      }
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

void func() async {
  _authenticateMe();
}

  @override
  Widget build(BuildContext context) {
    func();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [Center(child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Text('Use your fingerprint scanner to login.'),
          ))])
    );
  }
}