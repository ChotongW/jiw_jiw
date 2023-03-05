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
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
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
            const UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(color: const Color(0xff764abc)),
              accountName: Text(
                "jiw jiw local store",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "jiwjiw.store@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            Card(
              child: ListTile(
                title: const Text('Dash borad'),
                leading: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Inventory'),
                leading: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.pop(context);
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
