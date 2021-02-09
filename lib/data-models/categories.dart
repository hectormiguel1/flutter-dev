import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category implements Comparable {
  String name;
  Color color;
  String icon;
  Color iconColor;
  List<SubCategory> subcategories = [];

  Category(
      {@required this.name,
      @required this.color,
      @required this.icon,
      @required this.iconColor});

  bool addSubCategory(SubCategory subcat) {
    if (subcategories.contains(subcat)) {
      return false;
    } else {
      subcategories.add(subcat);
      return true;
    }
  }

  @override
  int compareTo(dynamic other) {
    return this.name.compareTo(other.name);
  }

  @override
  String toString() {
    return "Category: " +
        name +
        ", color: " +
        color.toString() +
        ", icon: " +
        icon +
        ", icon Color: " +
        iconColor.toString() +
        ", # subcategories: " +
        subcategories.length.toString();
  }
}

class SubCategory extends Category {
  Category parent;
  String name;
  String icon;
  Color iconColor;
  String evaluationText;
  String managementText;
  String medicationText;
  String symptomsText;
  String referencesText;

  SubCategory(
      {@required this.name,
      @required this.icon,
      @required this.parent,
      this.iconColor,
      this.evaluationText = 'evaluation',
      this.managementText = 'management',
      this.medicationText = 'medication',
      this.referencesText = 'referances',
      this.symptomsText = 'symptoms'});
}

Category categoryFromDocument(DocumentSnapshot doc) {
  return Category(
      name: doc.data['name'],
      color: Color(int.parse(doc.data['color'])),
      icon: doc.data['icon'],
      iconColor: Color(int.parse(doc.data['iconColor'])));
}

SubCategory subCategoryFromDocument(DocumentSnapshot doc, Category parent) {
  return SubCategory(
      name: doc.data['name'],
      icon: doc.data['icon'],
      iconColor: Color(int.parse(doc.data['iconColor'])),
      parent: parent,
      managementText: doc.data['manText'],
      evaluationText: doc.data['evalText'],
      medicationText: doc.data['medText'],
      referencesText: doc.data['refText'],
      symptomsText: doc.data['symptText']);
}
