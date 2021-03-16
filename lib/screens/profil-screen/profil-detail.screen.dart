import 'package:ensitapp/components/customer-bottom-bar.component.dart';
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/dialog/custom-loading.dialog.dart';
import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:ensitapp/services/post.service.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ProfilDetail extends StatefulWidget {
  final Customer customer;

  const ProfilDetail({Key key, this.customer}) : super(key: key);
  @override
  _ProfilDetailState createState() => _ProfilDetailState();
}

class _ProfilDetailState extends State<ProfilDetail> {
  List<Post> _postList;
  // bool _loadingPost = true;
  @override
  Future<void> initState() {
    super.initState();
    PostService().getPostsByUser(widget.customer.user.objectId).then((post) {
      _postList = post;
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
      body: Padding(
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
                          image: NetworkImage(widget.customer.picture),
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
              widget.customer.firstname,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: white),
            ),
            Text(
              widget.customer.grade,
              style: TextStyle(fontSize: 18, color: white),
            ),
            Text(
              widget.customer.status,
              style: TextStyle(fontSize: 18, color: white),
            ),
            Text(
              widget.customer.bio,
              style: TextStyle(fontSize: 18, color: white),
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
            _postList == null
                ? Center(
                    child: Text(
                      'Pas de post disponible',
                      style: TextStyle(fontSize: 18, color: white),
                    ),
                  )
                : Wrap(
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
