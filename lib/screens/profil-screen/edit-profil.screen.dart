import 'dart:io';

import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/dialog/loading.dialog.dart';
import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/screens/home-screen/home.screen.dart';
import 'package:ensitapp/services/customer.service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditProfilScreen extends StatefulWidget {
  @override
  _EditProfilScreenState createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  Customer _customer;
  File imageFile;
  @override
  initState() {
    super.initState();
    ParseUser.currentUser().then((user) {
      CustomerService().getByUser(user).then((customer) {
        setState(() {
          _customer = customer;
        });
      });
    });
  }

  Future<void> _showChoceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choisir entre options"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.photo),
                      Text("importer depuis la galerie"),
                    ],
                  ),
                  onTap: () {
                    _openGalerie2(context);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Text("Prendre une photo"),
                    ],
                  ),
                  onTap: () {
                    _openCamera2(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _openCamera2(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return null;
    }
    setState(() {
      imageFile = picture;
    });
  }

  _openGalerie2(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      return null;
    }
    setState(() {
      imageFile = picture;
    });
  }

  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController statusController = TextEditingController(); le faire en dropdown
  // faire pareil pour la classe
  String dropdownValue1 = 'Prépa 1';
  String dropdownValue2 = 'Étudiant';
  @override
  Widget build(BuildContext context) {
    if (_customer != null) {
      firstnameController.text = _customer.firstname;
      lastnameController.text = _customer.lastname;
      bioController.text = _customer.bio;
      this.dropdownValue1 = _customer.status;
      this.dropdownValue1 = _customer.grade;
    }
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 30,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Modification profil",
          style: TextStyle(
              color: white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: white),
                        child: imageFile != null
                            ? Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.file(
                                      imageFile,
                                      fit: BoxFit.cover,
                                    )),
                              )
                            : _customer == null
                                ? Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.asset(
                                          "assets/images/avatar3.jpeg",
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                : Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: _customer.picture != null
                                            ? Image.network(_customer?.picture)
                                            : Image.asset(
                                                "assets/unknow.jpeg")),
                                  ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          "Changer de Photo de profil",
                          style: TextStyle(
                              color: secondary,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _showChoceDialog(context);
                        },
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: firstnameController,
                autofocus: false,
                style: TextStyle(
                  fontSize: 22.0,
                  color: white,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: appBarColor,
                  hintText: "Entrez votre nom",
                  hintStyle: TextStyle(color: Colors.white54),
                  labelText: 'Nom',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // CustomTextField(
              //     hintext: "Entrez votre prénom",
              //     label: 'Prénom',
              //     type: TextInputType.text,
              //     controller: lastnameController)
              TextField(
                controller: lastnameController,
                autofocus: false,
                style: TextStyle(
                  fontSize: 22.0,
                  color: white,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: appBarColor,
                  hintText: "Entrez votre prénom",
                  hintStyle: TextStyle(color: Colors.white54),
                  labelText: 'Prénom',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // CustomTextField(
              //   hintext: "Entrez votre numéro",
              //   label: 'numéro de tel',
              //   type: TextInputType.number,
              //   controller: phoneNumberController,
              // )
              TextField(
                controller: phoneNumberController,
                autofocus: false,
                style: TextStyle(
                  fontSize: 22.0,
                  color: white,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: appBarColor,
                  hintText: "Entrez votre numéro",
                  hintStyle: TextStyle(color: Colors.white54),
                  labelText: 'numéro de tel',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Le niveau",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: white,
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topCenter,
                        child: DropdownButton<String>(
                          dropdownColor: primary,
                          value: dropdownValue1,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 10,
                          style: TextStyle(color: white),
                          underline: Container(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue1 = newValue;
                            });
                          },
                          items: <String>[
                            'Prépa 1',
                            'Prépa 2',
                            'Ingénieur 1',
                            'Ingénieur 2',
                            'Ingénieur 3'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 16, color: white),
                              ),
                            );
                          }).toList(),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Le statut",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: white,
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topCenter,
                        child: DropdownButton<String>(
                          dropdownColor: primary,
                          value: dropdownValue2,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 10,
                          style: TextStyle(color: white),
                          underline: Container(),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue2 = newValue;
                            });
                          },
                          items: <String>[
                            'Étudiant',
                            'Étudiante',
                            'Professionnel',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 16, color: white),
                              ),
                            );
                          }).toList(),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: bioController,
                autofocus: false,
                style: TextStyle(
                  fontSize: 22.0,
                  color: white,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: appBarColor,
                  hintText: "Entrez votre Bio",
                  hintStyle: TextStyle(color: Colors.white54),
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (_customer == null) {
                      Customer newCustomer = new Customer(
                          firstname: firstnameController.text,
                          lastname: lastnameController.text,
                          bio: bioController.text,
                          follow: [],
                          grade: dropdownValue1,
                          phoneNumber: phoneNumberController.text,
                          status: dropdownValue2,
                          picture: imageFile != null
                              ? imageFile.path
                              : "assets/images/avatar3.jpeg");
                      CustomerService customerService = CustomerService();
                      final ProgressDialog progressDialog =
                          showprogressDialog(context, dotRaduis: 6, raduis: 14);

                      progressDialog.show();
                      try {
                        final Customer response =
                            await customerService.create(newCustomer);
                        if (response != null) {
                          progressDialog.hide();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        print("======$e");
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "C'est partis",
                    style: TextStyle(fontSize: 20, color: secondary),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
