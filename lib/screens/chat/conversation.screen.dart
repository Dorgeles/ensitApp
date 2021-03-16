import 'package:ensitapp/components/customer-bottom-bar.component.dart';
import 'package:ensitapp/constant/color.constant.dart';
import 'package:flutter/material.dart';

class ConversationListScreen extends StatefulWidget {
  @override
  _ConversationListScreenState createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Text(
          "Conversation Screen",
          style: TextStyle(color: white),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1,
      ),
    );
  }
}
