import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_mobile_app/models/profile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
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
                    onPressed: () {
                      _key.currentState!.save();
                      print(
                          'email = ${profile.email} password ={profile.password}');
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            )),
      ),
    );
  }
}
