import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_mobile_app/models/database.dart';
import 'package:project_mobile_app/screens/authenticate/Login.dart';

import '../../models/profile.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function? register;
  const RegisterScreen({super.key, this.register});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator:
                        RequiredValidator(errorText: 'Please enter Username'),
                    decoration: InputDecoration(
                      hintText: 'Your Username',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? userName) {
                      profile.userName = userName!;
                    }),
                SizedBox(
                  height: 10,
                ),
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
                  height: 30,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () async {
                      _key.currentState!.save();
                      try {
                        dynamic result =
                            await _auth.registerEmailPassword(profile);

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
                          _db.writeUser(
                            userId: result.uid.toString(),
                            data: {
                              'userName': profile.userName,
                              'email': profile.email,
                            },
                          );

                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Register successfully"),
                                );
                              });
                          Navigator.pushReplacementNamed(context, '/auth');
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
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
