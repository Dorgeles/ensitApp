import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/models/customer.model.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final Customer customer;
  const StoryItem({
    Key key,
    this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: storyBorderColor)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: black, width: 2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          customer.picture,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 70,
            child: Text(
              customer.firstname,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white),
            ),
          )
        ],
      ),
    );
  }
}
