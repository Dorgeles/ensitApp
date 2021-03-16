import 'dart:io';
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/dialog/loading.dialog.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:ensitapp/screens/home-screen/home.screen.dart';
import 'package:ensitapp/services/post.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddingNewPostScreen extends StatefulWidget {
  @override
  _AddingNewPostScreenState createState() => _AddingNewPostScreenState();
}

class _AddingNewPostScreenState extends State<AddingNewPostScreen> {
  final picker = ImagePicker();
  List<String> tags = [];
  File images;
  List<File> tempImage = [];
  // fonctions de recuperation de fichiers
  Future<File> _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return null;
    }
    return picture;
  }

  Future<File> _openGalerie(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      return null;
    }
    return picture;
  }

  void optionOpen(context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          File files;
                          showDialog(
                              context: context,
                              useSafeArea: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Text("Galerie"),
                                          onPressed: () async {
                                            images =
                                                await _openGalerie(context);
                                            setState(() {
                                              images;
                                            });
                                            print(
                                                "============== ce que tu cherches ======$files");
                                            Navigator.of(context).pop();
                                            return null;
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("De la camera"),
                                          onPressed: () async {
                                            images = await _openCamera(context);
                                            setState(() {
                                              images;
                                            });
                                            print(
                                                "============== ce que tu cherches ======$files");
                                            Navigator.of(context).pop();
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Row(children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Ajouter une photo",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 20,
                    ),
                  ]))));
        });
  }

  TextEditingController descriptionCtlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'Ajouter un post',
          style: TextStyle(
              color: white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: descriptionCtlr,
              autofocus: false,
              style: TextStyle(
                fontSize: 22.0,
                color: white,
              ),
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: appBarColor,
                hintText: 'Pti speech',
                hintStyle: TextStyle(color: Colors.white54),
                labelText: "Description",
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_file_outlined),
                    Text(
                      "Ajouter un fichier",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: white),
                    ),
                  ],
                ),
                onTap: () {
                  optionOpen(context);
                },
              ),
            ),
            SizedBox(
              height: 150,
              child: images != null
                  ? Container(
                      height: 100,
                      width: 125,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.file(
                        images,
                        fit: BoxFit.cover,
                      ))
                  : Container(),
            ),
            TextButton(
                onPressed: () async {
                  Post newPost = Post(
                      description: descriptionCtlr.text,
                      imagePost: images.path,
                      likedBy: [],
                      listComment: []);
                  PostService postService = PostService();
                  final ProgressDialog progressDialog =
                      showprogressDialog(context, dotRaduis: 6, raduis: 14);

                  progressDialog.show();
                  try {
                    final Post response = await postService.create(newPost);
                    if (response != null) {
                      progressDialog.hide();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  } catch (e) {}
                },
                child: Text(
                  "Publier",
                  style: TextStyle(fontSize: 20, color: secondary),
                ))
          ],
        ),
      ),
    );
  }
}
