import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:fronthaus/app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fronthaus/providers/auth_provider.dart';
import 'package:fronthaus/providers/event_provider.dart';
import 'package:fronthaus/providers/map_provider.dart';
import 'package:fronthaus/providers/sessions_provider.dart';
import 'package:fronthaus/providers/speakers_provider.dart';
import 'package:fronthaus/providers/sponsors_provider.dart';
import 'package:fronthaus/providers/user_provider.dart';
import 'package:fronthaus/screens/main_content/agenda/components/body.dart';
import 'package:fronthaus/screens/main_content/book_session/book_session.dart';
import 'package:fronthaus/screens/main_content/event_home/event_home.dart';
import 'package:fronthaus/screens/main_content/map/map.dart';
import 'package:fronthaus/screens/main_content/event_home/components/body.dart';
import 'package:fronthaus/screens/main_content/more_feature/components/body.dart';
import 'package:fronthaus/screens/main_content/profile/profile.dart';
import 'package:fronthaus/screens/main_content/sessions/components/body.dart';
import 'package:fronthaus/screens/main_content/sessions/sessions.dart';
import 'package:fronthaus/screens/sign_in/sign_in.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  MainHomeState createState() => MainHomeState();
}

class MainHomeState extends State<MainHome> {
  int currentIndex = 0;

  final screens = [
    EventHomePage(),
    Agenda(),
    MapPage(),
    ProfilePage(),
    MoreFeature(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: currentIndex == 0 || currentIndex == 3
            ? screens[currentIndex]
            : SafeArea(child: screens[currentIndex]),

        // backgroundColor: backGroundColor,
        bottomNavigationBar: bottomAppBar(),
      ),
    );
  }

  //control bottom app bar
  BottomNavigationBar bottomAppBar() {
    return BottomNavigationBar(
      onTap: (index) => setState(() {
        if (index == 2) {
          Provider.of<MapProvider>(context, listen: false).getMap();
        }
        if (index == 3) {
          Provider.of<UserProvider>(context, listen: false).initial();
          Provider.of<UserProvider>(context, listen: false).showParticulars();
        }
        currentIndex = index;
      }),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: bottomNavBarColor,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home.svg'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/list.svg'),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/location.svg'),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/profile.svg'),
          label: 'Sessions',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/more.svg'),
          label: 'More',
        ),
      ],
    );
  }
}
