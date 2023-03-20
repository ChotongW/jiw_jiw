import 'package:form_field_validator/form_field_validator.dart';

import '../../models/profile.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final AuthService _auth = AuthService();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late UserCredential? _credential;

  // Future<void> signIn() async {
  //   try {
  //     final _credential = await _auth.signInWithEmailAndPassword(
  //         email: profile.email, password: profile.password);
  //     print("signed in ${_credential.user?.email}");
  //     // print(_credential.runtimeType);
  //     if (!context.mounted) return;
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter Email'),
                      EmailValidator(errorText: 'Please enter Email')
                    ]),
                    decoration: InputDecoration(
                      hintText: 'Your Email',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? email) {
                      profile.email = email!;
                    }),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Your Password',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                    validator:
                        RequiredValidator(errorText: 'Please enter Password'),
                    obscureText: true,
                    onSaved: (String? password) {
                      profile.password = password!;
                    }),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () async {
                      _key.currentState!.save();
                      try {
                        dynamic result =
                            await _auth.signInEmailPassword(profile);

                        if (result is FirebaseAuthException) {
                          //null means unsuccessfull authentication
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(result.message.toString()),
                                );
                              });
                        } else {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Login successfully"),
                                );
                              });
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.toString()),
                              );
                            });
                      }

                      // _key.currentState!.save();
                      // print(
                      //     'email = ${profile.email} password = ${profile.password}');
                      // signIn();
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.15,
                  onPressed: () {
                    // Navigate to a new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
