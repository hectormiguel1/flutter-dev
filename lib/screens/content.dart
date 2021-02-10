import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
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
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 20,
        child: Padding(padding: const EdgeInsets.all(10),
            child: ExpandablePanel(
              header: Text(section.capitalize(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              collapsed: Text(text.capitalize(), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis),
              expanded: SingleChildScrollView(
                  padding: const EdgeInsets.all(2),
                  scrollDirection: Axis.vertical,
                  child: Text(text.capitalize(), softWrap: true, style:
                    TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal)
            )
          )
        ),
      )

    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //SizedBox(height: 10),
            buildCard("evaluation", subCategory.evaluationText),
            //SizedBox(height: 10),
            buildCard('management', subCategory.managementText),
            //SizedBox(height: 10),
            buildCard("medication", subCategory.medicationText),
            //SizedBox(height: 10),
            buildCard("symptoms", subCategory.symptomsText),
            //SizedBox(height: 10),
            buildCard("references", subCategory.referencesText)
      ],
        )
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
