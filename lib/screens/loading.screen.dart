import 'package:ensitapp/constant/color.constant.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Text(
          "Chargement des données...",
          style: TextStyle(fontSize: 14, color: white),
        ),
      ),
    );
  }
}
