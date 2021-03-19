import 'package:ensitapp/constant/color.constant.dart';
import 'package:ensitapp/screens/chat/conversation.screen.dart';
import 'package:ensitapp/screens/home-screen/home.screen.dart';
import 'package:ensitapp/screens/profil-screen/detail-profil.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key key,
    @required int currentIndex,
  })  : _currentIndex = currentIndex,
        super(key: key);

  final int _currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: appFooterColor,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/home_icon.svg",
              height: 40,
              width: 40,
            ),
            activeIcon: SvgPicture.asset(
              "assets/images/home_active_icon.svg",
              height: 40,
              width: 40,
            ),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.send_outlined,
              color: white,
              size: 40,
            ),
            activeIcon: Icon(
              Icons.send,
              color: white,
              size: 40,
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline_sharp,
              color: white,
              size: 40,
            ),
            activeIcon: Icon(
              Icons.people_alt_sharp,
              color: white,
              size: 40,
            ),
            label: 'Profil',
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationListScreen(),
              ),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailProfilScrenn(),
              ),
            );
          }
        });
  }
}
