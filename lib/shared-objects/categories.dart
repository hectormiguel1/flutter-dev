
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pem_app_flutter/data-models/categories.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';

Firestore _databaseRef;
List<Category> _categories;
//This function initializes the categories structures.
void initCategories() {
  _categories = [];
  _databaseRef = getFirestoreDB();
  buildCategories();
}

/// Function gets the categories and subcategories, stored in firestore, values are stored in
/// categories.
/// Function is [async]
/// Function returns [Future<void>]
Future buildCategories() async {
  await _databaseRef
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
        _categories.add(tmpCategory);
    });
  });
}

/// [async] Function.
/// Function returns [List<SubCategory] when subcategories are red from databse.
/// [documentName] : Document to search for subcategories.
/// [parent] : Subcategory parent.
///
Future<List<SubCategory>> getSubCategory(
    String documentName, Category parent) async {
  List<SubCategory> tmpSubCats = [];
  await _databaseRef
      .collection('categories')
      .document(documentName)
      .collection('subcategories')
      .getDocuments()
      .then((querySnapshot) {
    querySnapshot.documents.forEach((document) {
      SubCategory tmpSubCategory = subCategoryFromDocument(document, parent);
      tmpSubCats.add(tmpSubCategory);
    });
  });
  return tmpSubCats;
}

List<Category> getCategories() {
  return _categories;
}