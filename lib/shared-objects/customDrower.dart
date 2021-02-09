import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/screens/category-screen.dart';
import 'package:pem_app_flutter/screens/login-screen.dart';
import 'package:pem_app_flutter/screens/profileView.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';

class CustomDrower {
  int selectedItem = 0;
  BuildContext context;
  int totalItems;
  User user = currentUser();

  List<Widget> drawerItems = [];

  CustomDrower({this.selectedItem = 0, @required this.context});

  void updateUI() {
    Widget avatarImage =
        user.profilePictureUrl.isEmpty || user.profilePictureUrl == null
            ? SvgPicture.asset(
                'assets/avatar.svg',
                width: 75,
                height: 75,
              )
            : Image.network(user.profilePictureUrl);
    DrawerHeader header = DrawerHeader(
      child: Column(children: [
        Center(
            child: Stack(
          children: [
            avatarImage,
            Positioned(
                bottom: 0,
                left: 0,
                child: Icon(Icons.fiber_manual_record,
                    color: user.isActive ? Colors.green : Colors.red))
          ],
        )),
        SizedBox(
          height: 10,
        ),
        Text(user.name),
        SizedBox(height: 10),
        Text(user.email)
      ]),
      decoration: BoxDecoration(color: Colors.blue[200]),
    );
    drawerItems.addAll([
      header,
      ListTile(
        leading: Icon(Icons.apps,
            color: this.selectedItem == 0 ? Colors.blue : Colors.grey),
        title: Text("Categories",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedItem == 0 ? Colors.blue : Colors.grey)),
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false);
        },
      ),
      ListTile(
        leading: Icon(Icons.account_box,
            color: this.selectedItem == 1 ? Colors.blue : Colors.grey),
        title: Text("Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: this.selectedItem == 1 ? Colors.blue : Colors.grey)),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfileView()));
        },
      ),
    ]);
    if (user.isAdmin) {
      drawerItems.add(
        ListTile(
          leading: Icon(Icons.edit,
              color: this.selectedItem == 3 ? Colors.blue : Colors.grey),
          title: Text("Edit Categories",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: this.selectedItem == 3 ? Colors.blue : Colors.grey)),
          onTap: () {
            //Handle move to favorites screen.
          },
        ),
      );
    }
    drawerItems.add(
      ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: Text(
          "Logut",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          _showDialog().then((response) {
            if (response) {
              signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else {
              print("Cancelled logout");
            }
          });
        },
      ),
    );
  }

  Future<bool> _showDialog() async {
    bool logout = false;
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout?"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  logout = true;
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("No"),
                onPressed: () {
                  logout = false;
                  Navigator.pop(context);
                },
              )
            ],
          );
        });

    return logout;
  }

  void setSelectedItem(int selectedItem) => this.selectedItem = selectedItem;

  Widget toWidget() {
    user = reloadUser();
    updateUI();
    return Drawer(
      elevation: 10,
      child: ListView.builder(
          itemCount: drawerItems.length,
          itemBuilder: (_, index) => drawerItems[index]),
    );
  }
}
