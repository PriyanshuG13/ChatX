import 'package:chatx/helper/constants.dart';
import 'package:chatx/helper/helperfunctions.dart';
import 'package:chatx/helper/theme.dart';
import 'package:chatx/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class MyProfile extends StatelessWidget {

  BoxDecoration gradientDefault = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    gradient: LinearGradient(
        colors: <Color>[Colors.redAccent, const Color(0xff2A75BC)],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(1.0, 1.0),
        stops: <double>[0.0, 1.0],
        tileMode: TileMode.clamp),
  );

  @override
  Widget build(BuildContext context) {

    Card customCard(Widget childWidget) => Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: gradientDefault,
            child: childWidget
        ));

    Padding customCardPadding(String str, {double size = 30}) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: 10),
        child: Text(
          str, style: GoogleFonts.combo(
          color: Colors.black,
          textStyle: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        ), textAlign: TextAlign.center,
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "User Profile",
            style: GoogleFonts.combo(
              color: Colors.white,
              textStyle: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                child: Icon(
                  Icons.edit,
                  size: 25,
                )),
          ),
          backgroundColor: Colors.black,
          actions: [
            Container(
              child: PopupMenuButton<int>(
                color: Colors.black,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        "  Settings",
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        "  Privacy",
                        style: TextStyle(color: Colors.white),
                      )),
                  PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          Text(
                            "  Logout",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ],
                onSelected: (item) => SelectedItem(context, item),
              ),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(5),
            color: Colors.black,
            child: ListView(
              children: [
                customCard(
                  Icon(
                    Icons.person,
                    size: 170,
                    color: Colors.black,
                  )
                ),
                customCard(customCardPadding(Constants.myName,size:40)),
                customCard(customCardPadding("Phone_Number")),
                customCard(customCardPadding("Email_Address")),
                customCard(customCardPadding("Thought of the Day",size:50)),
              ],
            )));
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print("Settings");
        break;
      case 1:
        print("Privacy Clicked");
        break;
      case 2:
        print("User Logged out");
        AuthService().signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
        break;
    }
  }
}
