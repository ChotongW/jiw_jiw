import 'package:flutter/material.dart';
import 'package:project_mobile_app/screens/appbar/theme.dart';
import 'package:provider/provider.dart';
import './theme.dart';
import '../../services/auth.dart';


class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  // const MyAppBar({Key? key}) : super(key: key);
  const MyAppBar({super.key, required this.title, required List actions});
  final String title;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final SignOut = Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.10,
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
      title: Text(widget.title),
      actions: <Widget>[SignOut,
      Switch.adaptive(
        value:  themeProvider.isDarkMode, 
        onChanged: (value){
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        } 
        )],
    );
  }
}
