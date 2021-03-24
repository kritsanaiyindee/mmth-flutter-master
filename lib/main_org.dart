import 'package:mmth_flutter/form/ro_create_form.dart';
import 'package:mmth_flutter/screens/image_pciker1.dart';
import 'package:mmth_flutter/screens/imagepicker.dart';
import 'package:mmth_flutter/screens/onboarding.dart';
import 'package:mmth_flutter/screens/passcode.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';

// screens

import 'package:mmth_flutter/screens/home_new.dart';
import 'package:mmth_flutter/screens/profile.dart';
import 'package:mmth_flutter/screens/AllChatsPage.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:mmth_flutter/screens/chat_screen.dart';
import 'package:mmth_flutter/screens/dashboard1.dart';
import 'package:mmth_flutter/screens/list_ro.dart';
import 'package:mmth_flutter/screens/list_ro_km.dart';
import 'package:mmth_flutter/screens/page1.dart';
import 'package:mmth_flutter/screens/rating.dart';
import 'package:mmth_flutter/screens/list_ro_case.dart';
import 'package:mmth_flutter/screens/settings.dart';
import 'package:mmth_flutter/screens/login_mitsu.dart';
import 'package:mmth_flutter/screens/splash.dart';

import 'package:responsive_framework/responsive_framework.dart';

import 'components/components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
            title: 'Mitsubishi Tech-Line',
            theme: ThemeData(fontFamily: 'Sarabun'),
            initialRoute: "/splash",
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              "/onboarding": (BuildContext context) => new Onboarding(),
              "/home": (BuildContext context) => new HomeMitsu(),
              //"/createcase": (BuildContext context) => new TextFormFieldDemo(),
              "/dashboard2": (BuildContext context) => new DashboardOnePage(),
              "/createro": (BuildContext context) => new Page1(),
              "/createcase": (BuildContext context) => new ROCreate(),
              "/profile": (BuildContext context) => new Profile(),
              "/listro": (BuildContext context) => new RoList(),
              //"/FauxLoginPage": (BuildContext context) => new FauxLoginPage(),
              //"/account": (BuildContext context) => new Register(),
              "/login2": (BuildContext context) => new LoginMitsu2(),
              "/ChatScreen": (BuildContext context) => new ChatScreen(),
              "/listcase": (BuildContext context) => new CaseROList(),
              "/listkm": (BuildContext context) => new CaseKMList(),
              "/passcode": (BuildContext context) => new PasscodePage(title: ""),
              "/splash": (BuildContext context) => new SplashScreen(),
              "/settings": (BuildContext context) => new Settings(),
              "/ChatPage": (BuildContext context) => new AllChatsPage(),
              "/rating": (BuildContext context) => new Rating2(),
              "/imagepcik": (BuildContext context) => new MyHomePage(title: 'Image Picker Example'),
              //"/chat": (BuildContext context) => new ChatScr(),
            },
            builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget),
              defaultScale: true,
              minWidth: 480,
              defaultName: MOBILE,
              breakpoints: [
                ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                ResponsiveBreakpoint.resize(600, name: MOBILE),
                ResponsiveBreakpoint.resize(850, name: TABLET),
                ResponsiveBreakpoint.resize(1080, name: DESKTOP),
            ],
            background: Container(color: background)),
    );

  }
}




