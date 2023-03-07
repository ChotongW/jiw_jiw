import 'package:project_mobile_app/inventory.dart';

import '../../services/auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  final String title = "Home Page";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[SignOut],
      ),
      body: const Center(
        child: Text('My Page!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: Text(
                _auth.currentUser.displayName.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                _auth.currentUser.email.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            Card(
              child: ListTile(
                title: const Text('Dash board'),
                leading: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.pop(context, MaterialPageRoute(builder: (context) {
                    return Stack();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Inventory'),
                leading: Icon(Icons.more_vert),
                onTap: () async {
                  // Navigator.pop(context);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Stock()),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Sell'),
                leading: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
