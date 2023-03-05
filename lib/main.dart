import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_mobile_app/screens/wrapper.dart';
import 'LoginAndregister/RegisterScreen.dart';
import 'firebase_options.dart';
import 'LoginAndregister/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';
import 'models/Firebaseuser.dart';
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
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            textTheme: ButtonTextTheme.primary,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: Wrapper(),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   void _logout(BuildContext context) async {
//     try {
//       // Sign out the current user using Firebase Authentication
//       final auth = FirebaseAuth.instance;
//       await auth.signOut();

//       // Navigate to the login screen after a successful logout
//       Navigator.pushReplacementNamed(context, '/login');
//     } on FirebaseAuthException catch (e) {
//       // Show an error message if the logout was unsuccessful
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: const Center(
//         child: Text('My Page!'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const UserAccountsDrawerHeader(
//               // <-- SEE HERE
//               decoration: BoxDecoration(color: const Color(0xff764abc)),
//               accountName: Text(
//                 "jiw jiw local store",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               accountEmail: Text(
//                 "jiwjiw.store@gmail.com",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               currentAccountPicture: FlutterLogo(),
//             ),
//             Card(
//               child: ListTile(
//                 title: const Text('Dash borad'),
//                 leading: Icon(Icons.more_vert),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: const Text('Inventory'),
//                 leading: Icon(Icons.more_vert),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: const Text('Sell'),
//                 leading: Icon(Icons.more_vert),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
