import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String phoneNumber;
  String password;

/*
 * Creates the user interface to register the user
 * Interface consits a form to capture new users name, email, phone number and password
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[50],
        body: Padding(
            padding: const EdgeInsets.all(50),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset('assets/logo.png'),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter your name"),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    obscureText: false,
                    validator: (val) =>
                        val.length < 2 ? "Enter a valid name" : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter your email"),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    obscureText: false,
                    validator: (val) {
                      if (val.contains('@') &&
                          val.contains('.') &&
                          val.length > 5) {
                        return null;
                      } else {
                        return "Enter a valid email";
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(hintText: "Enter your phone number"),
                    onChanged: (val) {
                      setState(() => phoneNumber = val);
                    },
                    obscureText: false,
                    validator: (val) =>
                        val.length < 10 ? "Enter a valid phone number" : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Create a password"),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                    validator: (val) => val.length < 6
                        ? "Password must be 6+ characters long"
                        : null,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Sign Up",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          User newUser = User(
                              name: name,
                              email: email,
                              phoneNumber: phoneNumber);
                          registerUser(newUser, password).then((success) {
                            if (success) {
                              Toast.show(
                                  "Account created successfuly!", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                              Navigator.pop(context, true);
                            } else {
                              Toast.show(
                                  "User already exists, Please login.", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            }
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)))
                ],
              ),
            )));
  }
}
