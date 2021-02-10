import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pem_app_flutter/data-models/users.dart';
import 'package:pem_app_flutter/shared-objects/customDrower.dart';
import 'package:pem_app_flutter/shared-objects/customNavBar.dart';
import 'package:pem_app_flutter/shared-objects/manage-connection.dart';

class ProfileView extends StatefulWidget {
  _ProfielViewState createState() => _ProfielViewState();
}

class _ProfielViewState extends State<ProfileView> {
  User user = reloadUser();
  CustomDrower drower;

  @override
  Widget build(BuildContext context) {
    updateUser(user);
    drower = CustomDrower(context: context, selectedItem: 1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Profile")),
      body: SizedBox.expand(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/profileview-background.jpeg'),
                fit: BoxFit.cover,
              )),
              child: body())),
      drawer: drower.toWidget(),
      bottomNavigationBar: CustomNavBar.buildNavBar(context: context),
    );
  }

  Widget body() {
    Widget avatarImage =
        user.profilePictureUrl.isEmpty || user.profilePictureUrl == null
            ? Image.asset('assets/default-profile-pic.jpg',
                scale: 2, fit: BoxFit.contain)
            : Image.network(user.profilePictureUrl);
    return SingleChildScrollView(
        child: Center(
            child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              child: user.profilePictureUrl.isEmpty ||
                      user.profilePictureUrl == null
                  ? Image.asset('assets/default-profile-pic.jpg',
                      fit: BoxFit.contain)
                  : Image.network(user.profilePictureUrl),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Icon(Icons.fiber_manual_record,
                    color: user.isActive ? Colors.green : Colors.red))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Text(user.title),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              splashColor: Colors.blue.shade100,
              elevation: 0,
              color: Colors.white.withAlpha(0),
              highlightElevation: 0,
              child: Column(
                children: [
                  Icon(Icons.sentiment_satisfied_alt),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Active Status"),
                ],
              ),
              onPressed: () {
                setState(() {
                  user.isActive = !user.isActive;
                  drower.updateUI();
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              splashColor: Colors.blue.shade100,
              elevation: 0,
              highlightElevation: 0,
              color: Colors.white.withAlpha(0),
              child: Column(
                children: [
                  Icon(Icons.edit),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Edit Profile"),
                ],
              ),
              onPressed: () {
                //Move to edit profile screen.
              },
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              highlightElevation: 0,
              splashColor: Colors.blue.shade100,
              color: Colors.white.withAlpha(0),
              elevation: 0,
              child: Column(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Calendar"),
                ],
              ),
              onPressed: () {
                //Move to add calendar event
              },
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        buildDetailButtons(Icons.email, "Email Address:", user.email),
        SizedBox(
          height: 20,
        ),
        buildDetailButtons(Icons.phone, "Phone Number:", user.phoneNumber),
        SizedBox(
          height: 20,
        ),
        buildDetailButtons(
            Icons.military_tech, "Certifications", "Tap to see more >>")
      ],
    )));
  }

  Widget buildDetailButtons(
      IconData icon, String sectionHeading, String sectionText) {
    return RaisedButton(
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
      elevation: 5,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
            height: 80,
          ),
          const VerticalDivider(
            color: Colors.grey,
            indent: 0,
            endIndent: 0,
            thickness: 1,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sectionHeading,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(sectionText),
            ],
          )
        ],
      ),
      onPressed: () {},
    );
  }
}
