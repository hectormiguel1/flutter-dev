import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:pem_app_flutter/screens/content.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/string_extension.dart';

class AllSubCategories extends StatefulWidget {
  List<Category> categories;

  AllSubCategories({@required this.categories});

  _AllSubCategoriesState createState() =>
      _AllSubCategoriesState(categories: categories);
}

class _AllSubCategoriesState extends State<AllSubCategories> {
  List<Category> categories;

  _AllSubCategoriesState({@required this.categories});

  Widget buildButtons(SubCategory subcat) {
    Widget icon = subcat.icon.isEmpty
        ? Icon(Icons.report_problem)
        : SvgPicture.asset(subcat.icon);
    return RaisedButton(
      elevation: 15,
      color: subcat.parent.color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 10),
          Text(subcat.name.capitalize()),
          SizedBox(
            width: 10,
          )
        ],
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContentScreen(subcat)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Categories")),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: const EdgeInsets.all(20),
        children: getSubCategories(),
      ),
      bottomNavigationBar:
          CustomNavBar.buildNavBar(context: context, selectedIndex: 1),
    );
  }

  List<Widget> getSubCategories() {
    List<Widget> subCatButtons = [];
    categories.forEach((element) {
      subCatButtons.addAll(element.subcategories.map(buildButtons).toList());
    });

    return subCatButtons;
  }
}
