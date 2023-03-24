// -----------------------------------------------------------------------------
// Hone.dart
// -----------------------------------------------------------------------------
//
// This file contains functions for display home page and hamberger
// Home page will explain What is this app do
// Hamberger will navigate to inventory

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../changetheme/changethemebutton.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../appbar/appbar.dart';
import '../appbar/theme.dart';

// -----------------------------------------------------------------------------
// Myhoepage
// -----------------------------------------------------------------------------
//
// The Myhoepage class is create Scaffold to display sizebox and drawer
// drawer will display listview that have current user name and email
// In hamberger will navigate to inventory

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
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   actions: <Widget>[SignOut],
      // ),
      appBar: MyAppBar(title: widget.title, actions: [
        ChangeThemeButtonWidget(),
      ]),
      body: Center(
        child: Row(
          children: [
            SizedBox(width: 60),
            Ink.image(
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2020/11/20/17/15/local-store-5762254_1280.png'),
              height: 500,
              width: 500,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 50),
            Column(
              children: [
                Align(),
                SizedBox(height: 200),
                Text('Jiw Jiw Local Store', style: TextStyle(fontSize: 50)),
                SizedBox(height: 40),
                Text(
                    'This application makes it easy for you to manage your stock.',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 40),
                Text(
                    'You can delete, add and edit the products you want through this app.',
                    style: TextStyle(fontSize: 20)),
              ],
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
            // Card(
            //   child: ListTile(
            //     title: const Text('Dash board'),
            //     leading: Icon(Icons.more_vert),
            //     onTap: () {
            //       Navigator.pop(context, MaterialPageRoute(builder: (context) {
            //         return Stack();
            //       }));
            //     },
            //   ),
            // ),
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
            // Card(
            //   child: ListTile(
            //     title: const Text('Sell'),
            //     leading: Icon(Icons.more_vert),
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
