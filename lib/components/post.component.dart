import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/services/customer.service.dart';
import 'package:ensitapp/services/post.service.dart';
import 'package:ensitapp/services/user.service.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostItem extends StatefulWidget {
  final Post post;
  const PostItem({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Customer _customer;

  @override
  initState() {
    super.initState();

    ParseUser.currentUser().then((user) {
      CustomerService().getByUser(user).then((customer) {
        setState(() {
          _customer = customer;
        });
      });
      // UserService().isCurrent(widget.post.user.objectId).then((value) {
      //   isOwner = value;
      // });
    });
  }

  TextEditingController commentCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.post.customer.picture),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.post.customer.firstname,
                      style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Text(
                  timeago.format(widget.post.createdAt, locale: 'en_short'),
                  style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.post.imagePost),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: IconButton(
                        padding: EdgeInsets.all(4),
                        constraints: BoxConstraints(),
                        icon: widget.post.likedBy.contains(_customer?.objectId)
                            ? Icon(
                                Icons.favorite,
                                size: 30,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                        onPressed: () async {
                          PostService postService = PostService();
                          if (widget.post.likedBy
                              .contains(_customer.objectId)) {
                            postService.onLike(
                                _customer.objectId, widget.post.objectId);
                            setState(() {
                              widget.post.likedBy.remove(_customer.objectId);
                            });
                          } else {
                            postService.onDisLike(
                                _customer.objectId, widget.post.objectId);

                            setState(() {
                              widget.post.likedBy.add(_customer.objectId);
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/comment_icon.svg",
                      width: 27,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/message_icon.svg",
                      width: 27,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/images/save_icon.svg",
                  width: 27,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Liked by ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              TextSpan(
                  text: "${widget.post.likedBy.length} ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              TextSpan(
                  text: "et ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              TextSpan(
                  text: "autre",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ])),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${widget.post.customer.firstname} ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                TextSpan(
                    text: "${widget.post.description}",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ]))),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Vue ${widget.post.listComment.length} Commentaires",
              style: TextStyle(
                  color: white.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 30,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: widget.post.listComment != null
                      ? widget.post.listComment
                          .map((e) => Text(
                                e.toString(),
                                style: TextStyle(color: white),
                              ))
                          .toList()
                      : Container(),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    style: TextStyle(color: white),
                    controller: commentCtrl,
                    decoration: InputDecoration(
                      hintText: "Ajouter un commentaire...",
                      hintStyle: TextStyle(
                          color: white.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            color: white.withOpacity(0.5),
                            size: 18,
                          ),
                          onPressed: () async {
                            PostService postService = PostService();
                            final response = postService.setComment(_customer,
                                widget.post.objectId, commentCtrl.text);
                            if (response != null) {
                              commentCtrl.text = "";
                            }
                            setState(() {
                              widget.post.listComment.add(commentCtrl.text);
                            });
                          })
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
