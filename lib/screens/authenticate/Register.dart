import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_mobile_app/screens/home/home.dart';

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
                        if (result.uid == null) {
                          //null means unsuccessfull authentication
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(result),
                                );
                              });
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
                      // else {
                      //   showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return MaterialButton(
                      //           minWidth:
                      //               MediaQuery.of(context).size.width * 0.15,
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //           child: Center(
                      //             child: Text(
                      //               'Ok',
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //         );
                      //       });
                      // }

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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterScreen()),
                    // );
                    widget.register!();
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
