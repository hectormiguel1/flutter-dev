import 'package:flutter/material.dart';

/*
 * This class can be used to retrive text from user, 
 * it suppports regular text and passwords. 
 * 
 * the final value of the text field is stored in the stored value 
 * variable. 
 * 
 * The class requires isPassword and hintText to be passed. 
 */
class CustomTextField {
  bool isPassword;
  String hintText;
  TextField field;
  String storedValue = '';
  CustomTextField({@required isPassword, @required hintText}) {
    field = new TextField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isPassword,
      onChanged: (value) {
        storedValue = value;
      },
    );
  }

  Widget toWidget() {
    return field;
  }

  String getValue() {
    return storedValue;
  }
}
