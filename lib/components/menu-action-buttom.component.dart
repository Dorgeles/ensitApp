import 'package:ensitapp/constant/color.constant.dart';
import 'package:flutter/material.dart';

class MenuAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final background;
  final Function press;

  const MenuAction({
    Key key,
    this.icon,
    this.title,
    this.background,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextButton(
        onPressed: press,
        child: Row(
          children: [
            Icon(
              this.icon,
              color: white,
              size: 30,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 20, color: white),
            )
          ],
        ),
      ),
    );
  }
}
