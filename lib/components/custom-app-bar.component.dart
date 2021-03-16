import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/screens/post-screen/adding-new-post.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: appBarColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Ensit App',
              style: TextStyle(
                  color: white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
              icon: SvgPicture.asset("assets/images/camera_icon.svg"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddingNewPostScreen(),
                  ),
                );
              })
        ],
      ),
    );
  }
}
