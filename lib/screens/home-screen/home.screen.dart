import 'package:ensitapp/components/custom-app-bar.component.dart';
import 'package:ensitapp/components/custom-drawer.component.dart';
import 'package:ensitapp/components/customer-bottom-bar.component.dart';
import 'package:ensitapp/components/post.component.dart';
import 'package:ensitapp/components/story-item.component.dart';
import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/dialog/custom-loading.dialog.dart';
import 'package:ensitapp/models/customer.model.dart';
import 'package:ensitapp/models/post.model.dart';
import 'package:ensitapp/screens/profil-screen/detail-profil.screen.dart';
import 'package:ensitapp/screens/profil-screen/profil-detail.screen.dart';
import 'package:ensitapp/services/customer.service.dart';
import 'package:ensitapp/services/post.service.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Customer _customer;
  List<Post> _posts = [];
  List<Customer> _listCustomer = [];
  bool _loading = true;
  @override
  Future<void> initState() {
    super.initState();
    ParseUser.currentUser().then((user) {
      CustomerService().getByUser(user).then((customer) {
        setState(() {
          _customer = customer;
          _loading = false;
        });
      });
    });
    PostService().filter().then((response) {
      setState(() {
        _posts = response ?? [];
      });
    });
    CustomerService().getAllCustomer().then((value) {
      setState(() {
        _listCustomer = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: CustomAppBar(),
      body: _loading
          ? Center(
              child: Container(
                child: ColorLoader3(
                  radius: 30,
                  dotRadius: 6,
                ),
              ),
            )
          : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            _listCustomer.isEmpty
                                ? Center(
                                    child: Container(
                                      child: ColorLoader3(
                                        radius: 30,
                                        dotRadius: 6,
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: _listCustomer != null
                                        ? _listCustomer
                                            .map((customer) => StoryItem(
                                                  customer: customer,
                                                  press: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilDetail(
                                                          customer: customer,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ))
                                            .toList()
                                        : [Container()]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: white.withOpacity(0.3),
                ),
                _posts.isEmpty
                    ? Center(
                        child: Container(
                          child: ColorLoader3(
                            radius: 30,
                            dotRadius: 6,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            child: Column(
                                children: _posts != null
                                    ? _posts
                                        .map((post) => PostItem(
                                              post: post,
                                            ))
                                        .toList()
                                    : [Container()]),
                          ),
                        ),
                      ),
              ],
            ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 0,
      ),
      drawer: CustomDrawer(),
    );
  }
}
