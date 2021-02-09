import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/screens/subCatView.dart';
import 'package:pem_app_flutter/shared-objects/customDrower.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final User logedinUser = currentUser();
  final Firestore _dbinstance = getFirestoreDB();
  List<Category> categories = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _drowerIndex = 0;

  _MainScreenState() {
    getCategories();
  }

/**
 * Function gets the categories and subcategories, stored in firestore, values are stored in 
 * categories.
 * Function is [async]
 * Function returns [Future<void>]
 */
  Future getCategories() async {
    await _dbinstance
        .collection('categories')
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Category tmpCategory = categoryFromDocument(result);
        getSubCategory(result.documentID, tmpCategory).then((value) {
          value.forEach((element) {
            tmpCategory.addSubCategory(element);
          });
        });
        setState(() {
          categories.add(tmpCategory);
        });
      });
    });
  }

/**
 * [async] Function. 
 * Function returns [List<SubCategory] when subcategories are red from databse.
 * [documentName] : Document to search for subcategories.
 * [parent] : Subcategory parent.
 *
 */
  Future<List<SubCategory>> getSubCategory(
      String documentName, Category parent) async {
    List<SubCategory> tmpSubCats = [];
    await _dbinstance
        .collection('categories')
        .document(documentName)
        .collection('subcategories')
        .getDocuments()
        .then((quarySnapshot) {
      quarySnapshot.documents.forEach((document) {
        SubCategory tmpSubCategory = subCategoryFromDocument(document, parent);
        tmpSubCats.add(tmpSubCategory);
      });
    });
    return tmpSubCats;
  }

/**
 * This function is used to build the tile button for the categories.
 * the function takes in a [category] and using the its properties, sets the
 * Button [color], [icon] [Text].
 * Function returns a [Widget]
 */
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

/**
 * Function is used to build the user interface in PortraitMode.
 * In this view, the userinterface is layed out in a 2x3 box grid.
 */
  Widget buildPortrait() {
    return Hero(
        tag: 'screen',
        child: Scaffold(
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
        ));
  }

/**
 * Function used to show logout confirmation dialog.
 */

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
