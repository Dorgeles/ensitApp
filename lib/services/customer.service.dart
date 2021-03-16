import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/models/storage.model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'acl.service.dart';
import 'storage.service.dart';

class CustomerService {
  //singleton
  static final CustomerService _service = CustomerService._internal();
  static final String _instanceRef = "Customer";

  factory CustomerService() {
    return _service;
  }

  CustomerService._internal();
  //fin singleton

  Future<Customer> create(Customer args) async {
    ParseUser user = await ParseUser.currentUser();
    final ParseObject pUser = ParseObject("_User");
    pUser.objectId = user.objectId;

    final _acl = await ACLService.ownerACL();
    Storage storage = await StorageService().create(filePath: args.picture);
    // print("customer-service l23 log customeruser " + args.firstname.toString());
    // print("customer-service l24 log customeruser " + args.lastname.toString());

    print("customer-service l26 log user " + user.toString());
    if (storage != null) {
      ParseObject pCustomer = ParseObject(_instanceRef)
        ..set("firstname", args.firstname)
        ..set("lastname", args.lastname)
        ..set("picture", storage.url)
        ..set("bio", args.bio)
        ..set("follow", args.follow)
        ..set("grade", args.grade)
        ..set("phoneNumber", args.phoneNumber)
        ..set("status", args.status)
        ..set("user", pUser);
      pCustomer.setACL(_acl);
      final response = await pCustomer.save();

      if (response.success) return Customer.fromParse(response.results.first);
      return null;
    } else {
      return null;
    }
  }

  Future<Customer> readOne(String objectId) async {
    final pCustomer = ParseObject(_instanceRef);
    final response = await pCustomer.getObject(objectId);
    if (response.success) return Customer.fromParse(response.results.first);
    return null;
  }

  Future<Customer> update(Customer args) async {
    Storage storage;
    ParseObject pCustomer = ParseObject(_instanceRef);
    pCustomer.objectId = args.objectId;

    if (args.picture != null) {
      storage = await StorageService().create(filePath: args.picture);
      pCustomer.set("photo", storage.url);
    }

    pCustomer
      ..set("firstname", args.firstname)
      ..set("lastname", args.lastname)
      ..set("bio", args.bio)
      ..set("follow", args.follow)
      ..set("grade", args.grade)
      ..set("phoneNumber", args.phoneNumber)
      ..set("status", args.status);

    final response = await pCustomer.save();

    if (response.success) return Customer.fromParse(response.results.first);
    return null;
  }

  Future<Customer> delete(objectId) async {
    final pCustomer = ParseObject(_instanceRef);
    pCustomer.objectId = objectId;
    final response = await pCustomer.delete();

    if (response.success) return Customer.fromParse(response.results.first);
    return null;
  }

  Future<List<Customer>> getCustomerList() async {
    QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(_instanceRef));
    final ParseResponse apiResponse = await queryBuilder.query();
    List<Customer> results = [];

    if (apiResponse.results != null)
      results = apiResponse.results.map((v) => Customer.fromParse(v)).toList();

    return results;
  }

  filter({String firstname, String lastname}) async {
    final pCustomer = ParseObject(_instanceRef);
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(pCustomer);
    query.setLimit(10);
    if (firstname != null) {
      query.whereContains('firstname', firstname);
    }
    if (lastname != null) {
      query.whereContains('lastname', lastname);
    }
    final response = await query.query();

    final results = response.results.map((v) => Customer.fromParse(v)).toList();
    return results;
  }

  Future<Customer> getByUser(ParseUser user) async {
    final pCustomer = ParseObject(_instanceRef);
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(pCustomer);

    ParseUser pUser = await ParseUser.currentUser();

    query.whereEqualTo("user", pUser);
    query.includeObject(["user"]);

    if (user != null) query.whereEqualTo("user", user);

    final response = await query.query();

    if (response.results != null)
      return Customer.fromParse(response.results.first);

    return null;
  }

  Future<List<Customer>> getAllCustomer() async {
    final pCustomer = ParseObject(_instanceRef);
    final QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(pCustomer);

    queryBuilder.setLimit(25);

    final response = await queryBuilder.query();
    dynamic results;

    if (response.results != null)
      results = response.results.map((v) => Customer.fromParse(v)).toList();
    return results;
  }

  Future<List<Customer>> getAllCustomerByGrade({String grade}) async {
    final pCustomer = ParseObject(_instanceRef);
    final QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(pCustomer);

    queryBuilder.whereEqualTo("grade", grade);

    final response = await queryBuilder.query();
    dynamic results;

    if (response.results != null)
      results = response.results.map((v) => Customer.fromParse(v)).toList();
    return results;
  }
}
