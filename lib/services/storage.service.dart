import 'dart:io';
import 'package:ensitapp/models/storage.model.dart';
import 'package:ensitapp/services/acl.service.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'image.service.dart';

class StorageService {
  //singleton
  static final StorageService _service = StorageService._internal();
  static final String _instanceRef = "Storage";

  factory StorageService() {
    return _service;
  }

  StorageService._internal();
  //fin singleton

  //methode create
  Future<Storage> create({String filePath, String name = "Media"}) async {
    final parseObject = ParseObject(_instanceRef);
    File compress = await compressImage(File(filePath));
    final _file = compress;
    final _acl = await ACLService.ownerACL();

    final ParseFile _parseFile = ParseFile(_file, name: name);

    parseObject.set("media", _parseFile);
    parseObject.set("title", name);
    parseObject.setACL(_acl);

    final response = await parseObject.save();

    if (response.success) return Storage.fromParse(response.results.first);
    return null;
  }

//methode delete
  Future<Storage> delete(objectId) async {
    final parseObject = ParseObject(_instanceRef);
    parseObject.objectId = objectId;
    final response = await parseObject.delete();

    if (response.success) return Storage.fromParse(response.results.first);
    return null;
  }
}
