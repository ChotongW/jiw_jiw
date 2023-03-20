import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../appbar/appbar.dart';

class allitem extends StatefulWidget {
  const allitem({super.key});

  @override
  State<allitem> createState() => _allitemState();
}

class _allitemState extends State<allitem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "AllItems",
        ),
        body: Container(
          child: Text('Hello'),
        ));
  }
}
