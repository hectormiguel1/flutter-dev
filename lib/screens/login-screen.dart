import 'package:flutter/material.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/screens/category-screen.dart';
import 'package:pem_app_flutter/screens/register.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';
import '../shared-objects/text-field.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatelessWidget {
  final emailField =
      CustomTextField(hintText: "Please enter email...", isPassword: false);
  final passField =
      CustomTextField(hintText: "Please enter password...", isPassword: true);

  Future<User> login(
      BuildContext context, String email, String password) async {
    User result = await lgoinUserWithPassword(password: password, email: email);
    if (result == null) {
      Toast.show("Icorrect email or password!", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return null;
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Center(
            child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            SizedBox(
                height: 200,
                width: 200,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset('assets/logo.png'))),
            SizedBox(height: 30),
            emailField.toWidget(),
            passField.toWidget(),
            SizedBox(height: 30),
            RaisedButton(
                elevation: 1,
                hoverElevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text("Login", style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (emailField.getValue().isEmpty ||
                      passField.getValue().isEmpty) {
                    Toast.show("Please enter email and password!", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  } else {
                    login(context, emailField.getValue(), passField.getValue())
                        .then((user) {
                      if (user != null) {
                        Toast.show("Welcome " + user.name, context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),
                            (Route<dynamic> route) => false);
                      }
                    });
                  }
                }),
            SizedBox(height: 10),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text("Login with Google",
                    style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: () {
                  Toast.show("This function is still in the works", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }),
            SizedBox(height: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              child: Text("Register"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            ),
          ],
        )));
  }
}
