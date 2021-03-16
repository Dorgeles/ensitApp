import 'customer.model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Post {
  final Customer customer;
  final String imagePost;
  final String description;
  final List<String> likedBy;
  final List<String> listComment;
  final String objectId;
  final DateTime createdAt;
  final DateTime updateAt;

  Post(
      {this.customer,
      this.imagePost,
      this.description,
      this.likedBy,
      this.listComment,
      this.objectId,
      this.createdAt,
      this.updateAt});

  Post.fromParse(ParseObject object)
      : customer = object.get('customer') != null
            ? Customer.fromParse(object.get('customer'))
            : null,
        imagePost = object.get('imagePost'),
        description = object.get('description'),
        likedBy = (object.get("likedBy") as List<dynamic>)
            ?.map((v) => v.toString())
            ?.toList(),
        listComment = (object.get("listComment") as List<dynamic>)
            ?.map((v) => v.toString())
            ?.toList(),
        objectId = object.objectId,
        createdAt = object.createdAt,
        updateAt = object.updatedAt;
}
