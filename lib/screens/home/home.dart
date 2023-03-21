import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../changetheme/changethemebutton.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';

import '../appbar/appbar.dart';
import '../appbar/theme.dart';

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
    ?'DarkTheme'
    :'LightTheme';
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   actions: <Widget>[SignOut],
      // ),
      appBar: MyAppBar(
        title: widget.title,
         actions:[ChangeThemeButtonWidget(),]
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 10),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  width: 500,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                      decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search here',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    prefix: Icon(
                      Icons.search,
                      size: 25,
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
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
