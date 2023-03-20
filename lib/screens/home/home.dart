import 'package:flutter_svg/svg.dart';

import '../../services/auth.dart';
import 'package:flutter/material.dart';

import '../appbar/appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
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
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   actions: <Widget>[SignOut],
      // ),
      appBar: MyAppBar(
        title: widget.title,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 77, 207, 81).withOpacity(0.03),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: Wrap(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF9C00).withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assetName"),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
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
              currentAccountPicture: Icon(
                Icons.person,
                size: 80,
              ),
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
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Stock()),
                  // );
                  await Navigator.pushNamed(context, '/inventory');
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
