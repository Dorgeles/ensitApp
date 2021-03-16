import 'package:timeago/timeago.dart' as timeago;
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({
    Key key,
    this.post,
  }) : super(key: key);

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
                              image: NetworkImage(post.customer.picture),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      post.customer.firstname,
                      style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Text(
                  timeago.format(post.createdAt, locale: 'en_short'),
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
                    image: NetworkImage(post.imagePost), fit: BoxFit.cover)),
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
                    SvgPicture.asset(
                      "assets/images/loved_icon.svg",
                      width: 27,
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
                  text: "${post.likedBy.length} ",
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
                    text: "${post.customer.firstname} ",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                TextSpan(
                    text: "${post.description}",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ]))),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Vue ${post.listComment.length} Commentaires",
              style: TextStyle(
                  color: white.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(post.customer.picture),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "ajouter un commentaire...",
                        style: TextStyle(
                            color: white.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "😂",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "😍",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.add_circle,
                        color: white.withOpacity(0.5),
                        size: 18,
                      )
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
