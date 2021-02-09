import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/screens/category-screen.dart';
import 'package:pem_app_flutter/screens/expanded.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';
import 'package:pem_app_flutter/shared-objects/string_extension.dart';
import 'package:pem_app_flutter/data-models/categories.dart';

class ContentScreen extends StatefulWidget {
  SubCategory subCategory;

  ContentScreen(this.subCategory);

  _ContentScreenState createState() => _ContentScreenState(subCategory);
}

class _ContentScreenState extends State<ContentScreen> {
  SubCategory subCategory;

  _ContentScreenState(this.subCategory);

  Widget buildCard(String section, String text) {
    return RaisedButton(
      elevation: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            section.capitalize() + ":",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(children: [
            SizedBox(height: 10),
            SizedBox(
                height: 50,
                child: Hero(
                    tag: section,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(text,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal)),
                    )))
          ]),
          SizedBox(
            height: 10,
          )
        ],
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ExpandedView(subCategory, section, text)));
      },
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        buildCard("evaluation", subCategory.evaluationText),
        SizedBox(height: 10),
        buildCard('management', subCategory.managementText),
        SizedBox(height: 10),
        buildCard("medication", subCategory.medicationText),
        SizedBox(height: 10),
        buildCard("symptoms", subCategory.symptomsText),
        SizedBox(height: 10),
        buildCard("references", subCategory.referencesText)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subCategory.parent.color,
      appBar: AppBar(
        title: Text(subCategory.name.capitalize()),
        backgroundColor: subCategory.iconColor,
      ),
      body: buildBody(),
      bottomNavigationBar: CustomNavBar.buildNavBar(
          context: context, selectedIndex: 1, bgColor: subCategory.iconColor),
    );
  }
}
