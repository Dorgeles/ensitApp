import 'package:parse_server_sdk/parse_server_sdk.dart';

// definition de la liste d'access et de controle
class ACLService {
  static Future<ParseACL> ownerACL() async {
    ParseUser user = await ParseUser.currentUser() as ParseUser;
    ParseACL parseACL = ParseACL(owner: user);
    parseACL.setPublicReadAccess(allowed: true);
    return parseACL;
  }

  static Future<ParseACL> privateACL() async {
    ParseUser user = await ParseUser.currentUser() as ParseUser;
    ParseACL parseACL = ParseACL(owner: user);
    parseACL.setPublicReadAccess(allowed: false);
    return parseACL;
  }

  static Future<ParseACL> readOnlyACL() async {
    ParseACL parseACL = ParseACL();
    parseACL.setPublicWriteAccess(allowed: false);
    parseACL.setPublicReadAccess(allowed: false);
    return parseACL;
  }
}
