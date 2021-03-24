import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mmth_flutter/constants/Theme.dart';

import 'package:mmth_flutter/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({this.currentPage});
  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.black,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            /*child: SafeArea(
              bottom: true,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Image.asset(
                    "assets/img/mitsu_logo.png",
                  ),
                ),
              ),
             )
             */
            ),
        Expanded(
          flex: 1,
          child: ListView(
            padding: EdgeInsets.only(top: 12, left: 16, right: 16),
            children: [
              DrawerTile(
                icon: Icons.home,
                onTap: () {
                  if (currentPage != "Home")
                    Navigator.pushReplacementNamed(context, '/home');
                },
                iconColor: ArgonColors.red_mitsu,
                title: "Home",
                isSelected: currentPage == "Home" ? true : false,
              ),
              /*DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "Create Case")
                      Navigator.pushReplacementNamed(context, '/createcase');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Create Case",
                  isSelected: currentPage == "Create Case" ? true : false),

               */
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Dashboard")
                      Navigator.pushReplacementNamed(context, '/dashboard2');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Dashboard",
                  isSelected: currentPage == "Dashboard" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "สร้าง CASE")
                      Navigator.pushReplacementNamed(context, '/createro');
                  },
                  iconColor: ArgonColors.warning,
                  title: "สร้าง CASE",
                  isSelected: currentPage == "สร้าง CASE" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.search,
                  onTap: () {
                    if (currentPage != "KM Search")
                      Navigator.pushReplacementNamed(context, '/listkm');
                  },
                  iconColor: ArgonColors.info,
                  title: "KM Search",
                  isSelected: currentPage == "KM Search" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.peopleArrows,
                  onTap: () {
                    if (currentPage != "Case Search")
                      Navigator.pushReplacementNamed(context, '/listcase');
                  },
                  iconColor: ArgonColors.red_mitsu,
                  title: "Your Case",
                  isSelected: currentPage == "Case Search" ? true : false),
              /*DrawerTile(
                  icon: Icons.settings_input_component,
                  onTap: () {
                    if (currentPage != "FauxLoginPage")
                      Navigator.pushReplacementNamed(context, '/FauxLoginPage');
                  },
                  iconColor: ArgonColors.error,
                  title: "FauxLoginPage",
                  isSelected: currentPage == "FauxLoginPage" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "Articles")
                      Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Articles",
                  isSelected: currentPage == "Articles" ? true : false),*/
              DrawerTile(
                  icon:  FontAwesomeIcons.windows,
                  onTap: () {
                    if (currentPage != "login1")
                      Navigator.pushReplacementNamed(context, '/onboarding');
                  },
                  iconColor: ArgonColors.primary,
                  title: "login1",
                  isSelected: currentPage == "login1" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.windows,
                  onTap: () {
                    if (currentPage != "login2")
                      Navigator.pushReplacementNamed(context, '/login2');
                  },
                  iconColor: ArgonColors.primary,
                  title: "login2",
                  isSelected: currentPage == "login2" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.snapchat,
                  onTap: () {
                    if (currentPage != "ChatScreen")
                      Navigator.pushReplacementNamed(context, '/ChatScreen');
                  },
                  iconColor: ArgonColors.red_mitsu,
                  title: "ChatScreen",
                  isSelected: currentPage == "ChatScreen" ? true : false),
            /*  DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "List Case")
                      Navigator.pushReplacementNamed(context, '/caselist');
                  },
                  iconColor: ArgonColors.primary,
                  title: "List Case",
                  isSelected: currentPage == "List Case" ? true : false),
              DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "Splash Screen")
                      Navigator.pushReplacementNamed(context, '/splash');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Splash",
                  isSelected: currentPage == "List Case" ? true : false),*/
              DrawerTile(
                  icon: FontAwesomeIcons.exchangeAlt,
                  onTap: () {
                    if (currentPage != "Settings")
                      Navigator.pushReplacementNamed(context, '/settings');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Settings",
                  isSelected: currentPage == "Settings" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.snapchat,
                  onTap: () {
                    if (currentPage != "ChatPage")
                      Navigator.pushReplacementNamed(context, '/ChatPage');
                  },
                  iconColor: ArgonColors.primary,
                  title: "ChatPage",
                  isSelected: currentPage == "ChatPage" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.pencilAlt,
                  onTap: () {
                    if (currentPage != "Rating")
                      Navigator.pushReplacementNamed(context, '/rating');
                  },
                  iconColor: Colors.amber,
                  title: "Rating",
                  isSelected: currentPage == "Rating" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.pencilAlt,
                  onTap: () {
                    if (currentPage != "Splash")
                      Navigator.pushReplacementNamed(context, '/splash');
                  },
                  iconColor: Colors.amber,
                  title: "Splash",
                  isSelected: currentPage == "Splash" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.pencilAlt,
                  onTap: () {
                    if (currentPage != "imagepcik")
                      Navigator.pushReplacementNamed(context, '/imagepcik');
                  },
                  iconColor: Colors.amber,
                  title: "imagepcik",
                  isSelected: currentPage == "Splash" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.pencilAlt,
                  onTap: () {
                    if (currentPage != "firebasechat")
                      Navigator.pushReplacementNamed(context, '/firebasechat');
                  },
                  iconColor: Colors.amber,
                  title: "firebasechat",
                  isSelected: currentPage == "Splash" ? true : false),


            ],
          ),
        ),
      ]),
    ));
  }
}
