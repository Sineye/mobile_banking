import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Mobile Banking'), centerTitle: true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          verticalDirection: VerticalDirection.down,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(shape: CircleBorder(), minimumSize: Size(200, 200)),
                onPressed: () { Navigator.pushNamed(context, '/fingerprint_login_screen');},
                child: Text('Fingerprint Login',textAlign: TextAlign.center,)
          ),
            )
    ,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  style: ElevatedButton.styleFrom(shape: CircleBorder(), minimumSize: Size(200, 200)),
                  onPressed: () { Navigator.pushNamed(context, '/password_login_screen');},
                  child: Text('Password Login',textAlign: TextAlign.center)
    ),
            )]
    ));
  }
}