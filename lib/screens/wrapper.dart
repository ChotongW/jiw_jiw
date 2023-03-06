import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../screens/home/home.dart';
import 'package:flutter/material.dart';

import 'authenticate/handler.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    // final user = Provider.of<FirebaseUser?>(context);
    // print(user?.uid);

    if (user == null) {
      return Handler();
    } else {
      return MyHomePage();
    }
  }
}
