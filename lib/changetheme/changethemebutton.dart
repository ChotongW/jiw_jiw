import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/appbar/theme.dart';


class ChangeThemeButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return  Switch.adaptive(
        value:  themeProvider.isDarkMode, 
        onChanged: (value){
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);

        } 
        );
    }
}