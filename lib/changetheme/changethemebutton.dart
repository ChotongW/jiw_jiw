//-------------------------------------------------------------
//Chattraphon Rangkavorn 630510614  (Feature should have: ChangeTheme)
//-------------------------------------------------------------
//This header file contains functions for efficiently concatenating and appending
//and cupertino and provider are used to create this page.
//This page a page pull app bar is used to make the class work.
//This page will be replaced into the appbar.dart .

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/appbar/theme.dart';

//-------------------------------------------------------------
//ChangeThemeButtonWidget.dart
//-------------------------------------------------------------
//
//The ChangeThemeButtonWidget is responsible for creating a switch button 
//that allows the user to change the theme of the app.
// It extends the StatelessWidget class. 
//This means that it has no changeable state. 
//Therefore, it is immutable.

class ChangeThemeButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ///it uses the Provider of method to get the current instance
    /// of ThemeProvider and then returns a Switch.adaptive widget. 
    final themeProvider = Provider.of<ThemeProvider>(context);

    return  Switch.adaptive(
      ///The value of the switch is set to the isDarkMode property of the themeProvider instance, 
      ///which is a boolean value indicating whether the app is currently in dark mode or not. 
        value:  themeProvider.isDarkMode, 
        ///The onChanged callback is set to a function 
        ///that toggles the theme by calling the toggleTheme method of the provider instance,
        /// passing in the value of the switch as an argument.
        onChanged: (value){
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);

        } 
        );
    }
}