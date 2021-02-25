import 'package:flutter/material.dart';
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
            child: SafeArea(
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
            )),
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
                iconColor: ArgonColors.primary,
                title: "Home",
                isSelected: currentPage == "Home" ? true : false,
              ),
              DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "Create Case")
                      Navigator.pushReplacementNamed(context, '/createcase');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Create Case",
                  isSelected: currentPage == "Create Case" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Create RO")
                      Navigator.pushReplacementNamed(context, '/createro');
                  },
                  iconColor: ArgonColors.warning,
                  title: "Create RO",
                  isSelected: currentPage == "Create RO" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "listro")
                      Navigator.pushReplacementNamed(context, '/listro');
                  },
                  iconColor: ArgonColors.info,
                  title: "listro",
                  isSelected: currentPage == "listro" ? true : false),
              DrawerTile(
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
                  isSelected: currentPage == "Articles" ? true : false),
              DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "login1")
                      Navigator.pushReplacementNamed(context, '/onboarding');
                  },
                  iconColor: ArgonColors.primary,
                  title: "login1",
                  isSelected: currentPage == "login1" ? true : false),
              DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "login2")
                      Navigator.pushReplacementNamed(context, '/login2');
                  },
                  iconColor: ArgonColors.primary,
                  title: "login2",
                  isSelected: currentPage == "login2" ? true : false),
              DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "ChatScreen")
                      Navigator.pushReplacementNamed(context, '/ChatScreen');
                  },
                  iconColor: ArgonColors.primary,
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
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "Settings")
                      Navigator.pushReplacementNamed(context, '/settings');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Settings",
                  isSelected: currentPage == "Settings" ? true : false),
              DrawerTile(
                  icon: Icons.accessibility_new,
                  onTap: () {
                    if (currentPage != "ChatPage")
                      Navigator.pushReplacementNamed(context, '/ChatPage');
                  },
                  iconColor: ArgonColors.primary,
                  title: "ChatPage",
                  isSelected: currentPage == "ChatPage" ? true : false),
            ],
          ),
        ),
      ]),
    ));
  }
}
