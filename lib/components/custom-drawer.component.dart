import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/dialog/search-choice.dialog.dart';
import 'package:ensitapp/dialog/search-list.dialog.dart';
import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/screens/home-screen/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu-action-buttom.component.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width / 1.5,
        padding: EdgeInsets.only(top: 0, bottom: 20, left: 10, right: 10),
        decoration: BoxDecoration(
          color: appBarColor,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black26),
                ),
              ),
              child: Column(children: [
                Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: white,
                        // child: Image.asset("assets/dummylogo.png")
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ensit App",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: screenSize.height / 11,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      MenuAction(
                        background: white,
                        title: "Accueil",
                        icon: Icons.home_outlined,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MenuAction(
                        background: white,
                        title: "Recherche",
                        icon: Icons.search_outlined,
                        press: () async {
                          List<String> searchChoice = [
                            "étidiant",
                            "Enseignant"
                          ];
                          String selectChoice = await radioDialog(
                              context, searchChoice, 'Vous recherchez?');
                          if (selectChoice == null) return null;
                          if (selectChoice == "étidiant") {
                            String selectedClass =
                                await radioClassDialog(context);
                            print(
                                " === on recherche $selectChoice dans la classe de $selectedClass");
                            if (selectedClass == null) return null;
                            if (selectedClass != null) {
                              Customer selectedCustomer =
                                  await showCustomerListDialog(context,
                                      grade: selectedClass,
                                      showMe: false,
                                      title: "List de recherche");
                              if (selectedCustomer == null) return null;
                              if (selectedCustomer != null) {
                                await canLaunch(
                                        'sms: +${selectedCustomer.phoneNumber}?body="Merci pour ton temps"')
                                    ? await launch(
                                        'sms: +${selectedCustomer.phoneNumber}?body="Merci pour ton temps"')
                                    : throw 'Could not launch ';
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ]))
        ]));
  }
}
