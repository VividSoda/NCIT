import 'package:flutter/material.dart';

class BlankRedirect extends StatelessWidget {
  const BlankRedirect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
              'Redirect successful'
          )
      ),
    );
  }
}
