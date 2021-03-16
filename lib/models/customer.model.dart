import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'user.model.dart';

class Customer {
  final String firstname;
  final String lastname;
  final String grade;
  final String status;
  final String bio;
  final String picture;
  final String phoneNumber;
  final User user;
  final List<String> follow;

  final String objectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer(
      {this.firstname,
      this.lastname,
      this.grade,
      this.status,
      this.bio,
      this.picture,
      this.phoneNumber,
      this.objectId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.follow});

  Customer.fromParse(ParseObject object)
      : firstname = object.get("firstname"),
        lastname = object.get("lastname"),
        user = object.get("user") != null
            ? User.fromParse(object.get("user"))
            : null,
        status = object.get("status"),
        follow = (object.get("follow") as List<dynamic>)
            ?.map((v) => v.toString())
            ?.toList(),
        bio = object.get("bio"),
        phoneNumber = object.get("phoneNumber"),
        picture = object.get("picture"),
        grade = object.get("grade"),
        objectId = object.objectId,
        createdAt = object.createdAt,
        updatedAt = object.updatedAt;
}
