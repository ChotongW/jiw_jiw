import 'package:flutter/material.dart';

class MyAlertDialog extends StatefulWidget {
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  int _count1 = 0;
  int _count2 = 0;

  void _incrementCount1() {
    setState(() {
      _count1++;
    });
  }

  void _decrementCount1() {
    setState(() {
      _count1--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('My Alert Dialog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decrementCount1,
              ),
              Text('Count 1: $_count1'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _incrementCount1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
