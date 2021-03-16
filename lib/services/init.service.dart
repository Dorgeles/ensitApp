import 'dart:io';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';

class InitService {
  //singleton
  static final InitService _service = InitService._internal();

  factory InitService() {
    return _service;
  }

  InitService._internal();
  //fin singleton

  Future<void> initParse() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    Directory directory =
        await new Directory(appDocDirectory.path + '/' + 'dir')
            .create(recursive: true);

    await Parse().initialize(
      "PxeLWsHPnqmA19PTxgYfGaK1c0dyVeJ2y36fJkKt",
      "https://parseapi.back4app.com/",
      clientKey:
          "IgSEEMczwguC4r2YYRdMrA8ABFy5Bn0ychQ61hoX", // Required for Back4App and others
      coreStore:
          await CoreStoreSembastImp.getInstance(directory.path + "/data.db"),
      debug: true, // When enabled, prints logs to console
      autoSendSessionId: true,
    );
    // Required for authentication and ACL
  }
}
