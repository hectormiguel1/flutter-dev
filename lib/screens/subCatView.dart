import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:pem_app_flutter/screens/content.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/string_extension.dart';

class SubCatView extends StatefulWidget {
  Category parentCategory;
  IconData placeHolderIcon = Icons.report_problem;

  SubCatView({@required this.parentCategory});
  _SubCatViewState createState() =>
      _SubCatViewState(mainCategory: parentCategory);
}

class _SubCatViewState extends State<SubCatView> {
  Category mainCategory;

  _SubCatViewState({@required this.mainCategory});

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

  Widget buildBody(Category mainCategory) {
    return mainCategory.subcategories == null
        ? Container()
        : GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            padding: const EdgeInsets.all(20),
            children: mainCategory.subcategories.map(buildButtons).toList(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(mainCategory.name.capitalize()),
            backgroundColor: mainCategory.iconColor,
          ),
          body: buildBody(mainCategory),
          bottomNavigationBar: CustomNavBar.buildNavBar(
              context: context,
              bgColor: mainCategory.iconColor,
              selectedIndex: 1),
        );
  }
}
