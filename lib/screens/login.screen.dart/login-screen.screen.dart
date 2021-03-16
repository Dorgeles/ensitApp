import 'package:ensitapp/components/customer-bottom-bar.component.dart';
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/screens/home-screen/home.screen.dart';
import 'package:ensitapp/screens/profil-screen/edit-profil.screen.dart';
import 'package:ensitapp/services/login-logout.service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dropdownValue = 'English';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int buttonColor = 0xff26A9FF;

  bool inputTextNotNull = false;

  @override
  Widget build(BuildContext context) {
    double deviseWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: DropdownButton<String>(
                      dropdownColor: primary,
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 10,
                      style: TextStyle(color: white),
                      underline: Container(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['English', 'Arabic', 'Italian', 'French']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16, color: white),
                          ),
                        );
                      }).toList(),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/appLogo.jpeg',
                      height: deviseWidth * .20,
                    ),
                    SizedBox(
                      height: deviseWidth * .05,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: usernameController,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Phone number , email or username',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    GestureDetector(
                      onTap: () async {
                        bool response = await doUserLogin(
                            password: passwordController.text.trim(),
                            username: usernameController.text.trim());
                        if (response == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilScreen(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Djo c'est projet de classe"),
                                content: Text(
                                    'Tu fais comment pour oublier ?.. tout pass \n Toi faut voir Haaa'),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        width: deviseWidth * .90,
                        height: deviseWidth * .14,
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            'Connecte toi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: deviseWidth * .040,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Quelque chose ne va pas ? ',
                          style: TextStyle(fontSize: 16, color: white),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Text("Djo c'est projet de classe"),
                                  content: Text(
                                      'Tu fais comment pour oublier ?.. tout pass \n Toi faut voir Haaa'),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "de l'aide!!",
                            style: TextStyle(
                              fontSize: 16,
                              color: secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviseWidth * .040,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
