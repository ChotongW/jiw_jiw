import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_mobile_app/screens/appbar/theme.dart';
import 'package:project_mobile_app/screens/item/allitems.dart';
import 'package:project_mobile_app/screens/item/delete.dart';
import 'package:project_mobile_app/screens/item/drink.dart';
import 'package:project_mobile_app/screens/item/list_item.dart';
import 'package:project_mobile_app/screens/item/search.dart';
import 'package:project_mobile_app/services/addItem.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'inventory.dart';
import 'screens/authenticate/Login.dart';
import 'screens/home/home.dart';
import 'services/auth.dart';


// import 'screens/wrapper.dart';
// import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'jiw jiw local store';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
    // return MaterialApp(
    //   title: appTitle,
    //   initialRoute: '/login',
    //   routes: {
    //     '/login': (context) => const LoginScreen(),
    //     '/home': (context) => const MyHomePage(
    //           title: appTitle,
    //         ),
    //   },
    //   home: LoginScreen(),
    // );
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        // StreamProvider<FirebaseUser?>(
        //   create: (context) => context.read()<AuthService>().user,
        //   initialData: null,
        // ),
        // StreamProvider<User?>.value(
        //   value: AuthService().user,
        //   // create: (context) => AuthService().user,
        //   initialData: null,
        // ),
      ],
      child: MaterialApp(
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => LoginScreen(),
          '/home': (context) => MyHomePage(
                title: appTitle,
              ),
          '/inventory': (context) => Stock(),
          '/catagory': (context) => itemList(),
          '/addItem': (context) => AddItem(),
          '/drink': (context) => Search(
                category: 'drink',
              ),
          '/fresh meal': (context) => Search(
                category: 'fresh meal',
              ),
          '/snacks': (context) => Search(
                category: 'snacks',
              ),
          '/frozen & processed food': (context) => Search(
                category: 'frozen & processed food',
              ),
          '/pets': (context) => Search(
                category: 'pets',
              ),
          '/household goods': (context) => Search(
                category: 'household goods',
              ),
          '/shower': (context) => Search(
                category: 'shower',
              ),
          '/mom and kids': (context) => Search(
                category: 'mom and kids',
              ),
          '/fresh product': (context) => Search(
                category: 'fresh product',
              ),
          '/delete': (context) => delete(),
          '/allitems': (context) => allitem(),
        },
        title: appTitle,
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        // home: Wrapper(),
      ),
    );
  }
  );
}
