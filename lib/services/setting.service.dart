import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/models/user.model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customer.service.dart';
import 'user.service.dart';

class SettingService {
  static final SettingService _service = SettingService._internal();

  factory SettingService() {
    return _service;
  }

  SettingService._internal();

  Future<bool> isFirstOpen() async {
    final pref = await SharedPreferences.getInstance();
    final isFirstOpen = pref.getBool("isFirstOpen");

    if (isFirstOpen == null) {
      return false;
    }
    return isFirstOpen;
  }

  Future<bool> isAuth() async {
    final UserService userService = UserService();
    User user = await userService.getCurrent();
    if (user == null) {
      return false;
    }
    return true;
  }

  Future<bool> isCustomer() async {
    final pUser = await ParseUser.currentUser();
    print("$pUser");
    final CustomerService service = CustomerService();
    Customer customer = await service.getByUser(pUser);
    if (customer == null) {
      return false;
    }
    return true;
  }

  Future<bool> setFirstOpen() async {
    final pref = await SharedPreferences.getInstance();
    final test = pref.getBool("isFirstOpen");

    print("Settings service L54 " + test.toString());

    final isFirstOpen = await pref.setBool("isFirstOpen", true);
    print("Settings service L54 " + isFirstOpen.toString());

    return isFirstOpen;
  }
}
