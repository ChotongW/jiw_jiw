import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_mobile_app/screens/item/list_item.dart';
import 'package:project_mobile_app/screens/item/search.dart';
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
  Widget build(BuildContext context) {
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
          // '/search': (context) => Search(),
          'Drink': (context) => Search(),
        },
        title: appTitle,
        // home: Wrapper(),
      ),
    );
  }
}
