import 'package:flutter/material.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';
import 'package:pem_app_flutter/shared-objects/string_extension.dart';

class ExpandedView extends StatefulWidget {
  SubCategory subCategory;
  String section;
  String text;
  ExpandedView(this.subCategory, this.section, this.text);

  _ExpandedViewState createState() =>
      _ExpandedViewState(subCategory, text, section);
}

class _ExpandedViewState extends State<ExpandedView> {
  SubCategory subCategory;
  String section;
  String text;

  _ExpandedViewState(this.subCategory, this.text, this.section);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(section.capitalize()),
          backgroundColor: subCategory.parent.iconColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Hero(
            tag: section,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                scrollDirection: Axis.vertical,
                child: Text(text,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal))),
          )
        ],
      ),
      bottomNavigationBar: CustomNavBar.buildNavBar(
          context: context, bgColor: subCategory.iconColor, selectedIndex: 1),
    );
  }
}
