import 'package:parse_server_sdk/parse_server_sdk.dart';

class Storage {
  String objectId;
  DateTime createdAt;
  DateTime updatedAt;
  ParseFile media;
  String url;
  bool deleted;

  Storage({this.media, this.url, this.deleted});

  Storage.fromParse(ParseObject object)
      : url = (object.get("media") as ParseFile).url,
        media = object.get("media"),
        objectId = object.objectId,
        createdAt = object.createdAt,
        updatedAt = object.updatedAt,
        deleted = object.get("deleted");
}
