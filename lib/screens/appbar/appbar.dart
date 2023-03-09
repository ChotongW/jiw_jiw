import 'package:flutter/material.dart';

import '../../services/auth.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);
  final String title = "Home Page";
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final SignOut = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.15,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            await _auth.signOut();
            Navigator.pushReplacementNamed(context, '/auth');
          } catch (e) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(e.toString()),
                  );
                });
          }
          // var res = await _auth.signOut();
          // print(res);
        },
        child: Text(
          "Log out",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return AppBar(
      title: Text('My App'),
    );
  }
}
