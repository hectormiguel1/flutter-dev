import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/screens/subCatView.dart';
import 'package:pem_app_flutter/shared-objects/categories.dart';
import 'package:pem_app_flutter/shared-objects/customDrower.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final User logedinUser = currentUser();
  List<Category> categories = getCategories();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _drowerIndex = 0;

/// This function is used to build the tile button for the categories.
/// the function takes in a [category] and using the its properties, sets the
/// Button [color], [icon] [Text].
/// Function returns a [Widget]
  Widget buildButton(Category category) {
    return RaisedButton(
      elevation: 15,
      color: category.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            category.icon,
            color: category.iconColor,
          ),
          SizedBox(height: 10),
          Text(
            category.name,
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCatView(parentCategory: category)))
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    categories.sort();
    return buildPortrait();
  }


/// Function is used to build the user interface in PortraitMode.
/// In this view, the user interface is layered out in a 2x3 box grid.
  Widget buildPortrait() {
    return Scaffold(
          key: _scaffoldKey,
          drawer: buildDrower(),
          appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    //Handle move to search view
                  },
                )
              ],
              title: Text("Categories"),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => {_scaffoldKey.currentState.openDrawer()},
              )),
          body: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(30),
            children: categories.map(buildButton).toList(),
          ),
          bottomNavigationBar: CustomNavBar.buildNavBar(
              context: context, categories: categories),
        );
  }
/*
 *  Function builds the drawer used for the side navigation pane.
 */
  Widget buildDrower() {
    CustomDrower drawer = CustomDrower(
      context: context,
    );
    return drawer.toWidget();
  }
}
