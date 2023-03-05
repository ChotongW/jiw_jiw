import 'package:provider/provider.dart';
import '../screens/home/home.dart';
import 'package:flutter/material.dart';

import '../models/FirebaseUser.dart';
import 'authenticate/handler.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<FirebaseUser?>();

    if (user == null) {
      return Handler();
    } else {
      return MyHomePage();
    }
  }
}
