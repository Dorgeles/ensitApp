import 'package:ensitapp/components/customer-bottom-bar.component.dart';
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/dialog/custom-loading.dialog.dart';
import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:ensitapp/screens/profil-screen/edit-profil.screen.dart';
import 'package:ensitapp/services/customer.service.dart';
import 'package:ensitapp/services/post.service.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class DetailProfilScrenn extends StatefulWidget {
  final Customer customer;

  const DetailProfilScrenn({Key key, this.customer}) : super(key: key);
  @override
  _DetailProfilScrennState createState() => _DetailProfilScrennState();
}

class _DetailProfilScrennState extends State<DetailProfilScrenn> {
  Customer _customer;
  List<Post> _postList;
  bool _loading = true;
  // bool _loadingPost = true;
  @override
  Future<void> initState() {
    super.initState();
    ParseUser.currentUser().then((user) {
      CustomerService().getByUser(user).then((customer) {
        setState(() {
          _customer = customer;
          _loading = false;
        });
      });
      PostService().getPostsByUser().then((post) {
        _postList = post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        title: Text(
          'Profil',
          style: TextStyle(
              color: white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: ColorLoader3(
                  radius: 30,
                  dotRadius: 6,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: white,
                            image: DecorationImage(
                                image: NetworkImage(_customer.picture),
                                fit: BoxFit.cover)),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(color: white),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "10",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              Text(
                                "Suiveurs",
                                style: TextStyle(color: white),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "30",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              Text(
                                "Suivis",
                                style: TextStyle(color: white),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _customer.firstname,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                  Text(
                    _customer.grade,
                    style: TextStyle(fontSize: 18, color: white),
                  ),
                  Text(
                    _customer.status,
                    style: TextStyle(fontSize: 18, color: white),
                  ),
                  Text(
                    _customer.bio,
                    style: TextStyle(fontSize: 18, color: white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                          borderSide: BorderSide(
                            width: 1,
                            color: white,
                            style: BorderStyle.solid,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Modifier le profil',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: _postList.map<Widget>((post) {
                      return PostImage(
                        post: post,
                      );
                    }).toList()
                    // je dois mettre les post crée ici
                    ,
                  )
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 2,
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  final Post post;

  const PostImage({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(post.imagePost),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
