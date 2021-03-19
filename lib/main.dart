import 'package:ensitapp/screens/home-screen/home.screen.dart';
import 'package:ensitapp/screens/loading.screen.dart';
import 'package:ensitapp/services/setting.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/login.screen.dart/login-screen.screen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'screens/login.screen.dart/register.screen.dart';
import 'screens/profil-screen/edit-profil.screen.dart';
import 'services/init.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  final InitService init = InitService();
  await init.initParse();
  // ParseUser("dorge", "dorge", "dorge@gmail.com").login();

  runApp(
    MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Ensit App",
      theme: ThemeData(fontFamily: 'Billabong'),
      home: FutureBuilder<bool>(
          future: SettingService().isFirstOpen(),
          builder: (BuildContext context, AsyncSnapshot<bool> openSnapshot) {
            if (openSnapshot.data == null)
              return LoadingScreen();
            else if (openSnapshot.data == false)
              return LoginScreen();
            else {
              return FutureBuilder<bool>(
                future: SettingService().isAuth(),
                builder:
                    (BuildContext context, AsyncSnapshot<bool> userSnapshot) {
                  if (userSnapshot.data == null) {
                    return LoadingScreen();
                  } else if (userSnapshot.data == false) {
                    return LoginScreen();
                  } else {
                    return FutureBuilder<bool>(
                      future: SettingService().isCustomer(),
                      builder: (BuildContext context,
                          AsyncSnapshot<bool> customerSnapshot) {
                        if (customerSnapshot.data == null) {
                          return LoadingScreen();
                        }
                        if (customerSnapshot.data == false) {
                          return EditProfilScreen();
                        } else {
                          return HomeScreen();
                        }
                      },
                    );
                  }
                },
              );
            }
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
