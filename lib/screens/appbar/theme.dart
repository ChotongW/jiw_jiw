//-------------------------------------------------------------
//Chattraphon Rangkavorn 630510614  (Feature should have: ChangeTheme)
//-------------------------------------------------------------
//This header file contains functions for efficiently concatenating and appending.
//and have APIs for interacting with the scheduler, 
//which is responsible for managing the event queue and scheduling tasks to run at specific times.
////This file will be run on the home.dart ,appbar.dart and main.dart.
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//-------------------------------------------------------------
//Theme.dart
//-------------------------------------------------------------
//
//The ThemeProvider class act  extends the ChangeNotifier class in Flutter. 
//The ChangeNotifier class provides a convenient way to manage and 
//notify user of changes to the class's state.
class ThemeProvider extends ChangeNotifier {
  ///themeMode that represents the current theme mode of the app
  ThemeMode themeMode = ThemeMode.system;

  ///The isDarkMode method is a getter that returns a boolean indicating 
  ///whether the app is currently in dark mode.
  bool get isDarkMode {
    /// If themeMode is set to ThemeMode.system, then the method retrieves the platform brightness
    if (themeMode == ThemeMode.system) {
      ///using SchedulerBinding.instance.window.platformBrightness and
      /// returns true if the brightness is Brightness.dark, 
      /// indicating that the device is currently in dark mode.
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      ///
      return themeMode == ThemeMode.dark;
    }
  }
  
  ///The toggleTheme method takes a boolean parameter called isOn,
  /// which represents whether the user wants to switch to dark mode (true) or light mode (false).
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

//MyThemes class that provides the dark and light themes for the app. 
//The darkTheme and lightTheme variables are static and final properties 
//that are instances of the ThemeData class
class MyThemes {
  //set about darktheme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  //set about darktheme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}



