import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:ensitapp/models/storage.model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'customer.service.dart';
import 'storage.service.dart';

class PostService {
  //singleton
  static final PostService _service = PostService._internal();
  static final String _instanceRef = "Post";

  factory PostService() {
    return _service;
  }

  PostService._internal();
  //fin singleton

  Future<Post> create(Post args) async {
    Customer customer = await CustomerService().getByUser(null);
    ParseObject pCustomer = ParseObject("Customer");
    pCustomer.objectId = customer.objectId;
    ParseUser pUser = await ParseUser.currentUser();
    //final _acl = await ACLService.ownerACL();

    Storage imagePost = await StorageService().create(filePath: args.imagePost);

    //  List<Storage>  storagepostPictures = await StorageService().create(filePath: args.postPictures.toList());

    ParseObject pPost = ParseObject(_instanceRef)
      ..set("customer", pCustomer)
      ..set("user", pUser)
      ..set("listComment", args.listComment)
      ..set("likedBy", args.likedBy)
      ..set("description", args.description)
      ..set("imagePost", imagePost.url);
    final response = await pPost.save();

    if (response.results != null) return Post.fromParse(response.results.first);
    return null;
  }

  Future<Post> readOne(String objectId) async {
    final pPost = ParseObject(_instanceRef);
    final response = await pPost.getObject(objectId);
    if (response.success) return Post.fromParse(response.results.first);
    return null;
  }

  Future<List<ParseObject>> getDataPost() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('Post'));
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results;
    } else {
      return [];
    }
  }

  Future<Post> delete(objectId) async {
    final pPost = ParseObject(_instanceRef);
    pPost.objectId = objectId;
    final response = await pPost.delete();

    if (response.success) return Post.fromParse(response.results.first);
    return null;
  }

  filter([String name]) async {
    final pPost = ParseObject(_instanceRef);
    final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(pPost);
    query.setLimit(50);
    query.orderByDescending("updatedAt");
    query.includeObject([
      "customer.firstname",
      "user",
      "customer.picture",
      "customer.lastname",
    ]);

    if (name != null) {
      query.whereContains('name', name);
    }
    final response = await query.query();
    dynamic results;

    if (response.results != null)
      results = response.results.map((v) => Post.fromParse(v)).toList();

    return results;
  }

  Future<List<Post>> getPostsByUser([String userId]) async {
    final pPost = ParseObject(_instanceRef);
    final QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(pPost);

    queryBuilder.includeObject(["customer"]);

    queryBuilder.setLimit(50);

    ParseUser user = await ParseUser.currentUser();

    if (userId != null) user.objectId = userId;

    queryBuilder.whereEqualTo("user", user);

    final response = await queryBuilder.query();

    dynamic results;

    if (response.results != null)
      results = response.results.map((v) => Post.fromParse(v)).toList();
    return results;
  }

  onLike(String customerId, String postId) async {
    var newPost = ParseObject('Post')..objectId = postId;
    newPost.setRemove("likedBy", customerId);
    newPost.save();
  }

  onDisLike(String customerId, String postId) async {
    var newPost = ParseObject('Post')..objectId = postId;
    newPost.setAdd("likedBy", customerId);
    newPost.save();
  }

  setComment(Customer customer, String postId, String comment) async {
    var newPost = ParseObject('Post')..objectId = postId;
    newPost.setAdd("listComment", "${customer.firstname} dit que ${comment}");
    newPost.save();
  }
}

// post = ParseObject("Post")
// ..set("profilPicture", args.profilPicture)
// ..set("name", args.name)
// ..set("address", args.address)
// ..set("content", args.content)
// ..set("likes", args.likes)
// ..set("services", args.services)
// ..set("postPictures", args.postPictures)
// ..set("date", args.date);