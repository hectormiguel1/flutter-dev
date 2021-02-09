import 'package:flutter/material.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:pem_app_flutter/screens/all-subcategories.dart';
import 'package:pem_app_flutter/screens/category-screen.dart';

class CustomNavBar {
  static Widget buildNavBar({
    BuildContext context,
    int selectedIndex = 0,
    List<Category> categories = const [],
    Color bgColor = Colors.blue,
  }) {
    return BottomNavigationBar(
      backgroundColor: bgColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Subcategories"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      onTap: (selection) {
        if (selection == selectedIndex) {
          //Do nothing
        } else {
          if (selection == 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (Route<dynamic> route) => false);
          } else if (selection == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AllSubCategories(categories: categories)));
          } else if (selection == 2) {
            //Do Move to Chat View
          }
        }
      },
    );
  }
}
