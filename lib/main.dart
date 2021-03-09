import 'package:mmth_flutter/form/ro_create_form.dart';
import 'package:mmth_flutter/screens/AllChatsPage.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:mmth_flutter/screens/FauxLoginPage.dart';
import 'package:mmth_flutter/screens/chat.dart';
import 'package:mmth_flutter/screens/chat_screen.dart';
import 'package:mmth_flutter/screens/dashboard1.dart';
import 'package:mmth_flutter/screens/list_ro.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mmth_flutter/screens/login_mitsu.dart';
import 'package:mmth_flutter/screens/splash.dart';

import 'package:flutter/material.dart';

// screens
import 'package:mmth_flutter/screens/onboarding.dart';
import 'package:mmth_flutter/screens/home_new.dart';
import 'package:mmth_flutter/screens/profile.dart';
import 'package:mmth_flutter/screens/register.dart';

import 'package:mmth_flutter/screens/rating.dart';
import 'package:mmth_flutter/screens/list_ro_case.dart';
import 'package:mmth_flutter/form/case_create_form.dart';
import 'package:mmth_flutter/screens/settings.dart';


const URL = 'ws://YOUR.SERVER.URL:PORT';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChatModel>(
        model: ChatModel(),
        child: MaterialApp(
            title: 'Mitsubishi Tech-Line',
            theme: ThemeData(fontFamily: 'Sarabun'),
            initialRoute: "/splash",
            debugShowCheckedModeBanner: false,
            routes: <String, WidgetBuilder>{
              "/onboarding": (BuildContext context) => new Onboarding(),
              "/home": (BuildContext context) => new HomeMitsu(),
              "/createcase": (BuildContext context) => new TextFormFieldDemo(),
              "/dashboard2": (BuildContext context) => new DashboardOnePage(),
              "/createro": (BuildContext context) => new ROCreate(),
              "/profile": (BuildContext context) => new Profile(),
              "/listro": (BuildContext context) => new RoList(),
              "/FauxLoginPage": (BuildContext context) => new FauxLoginPage(),
              "/account": (BuildContext context) => new Register(),
              "/login2": (BuildContext context) => new LoginMitsu2(),
              //"/ChatScreen": (BuildContext context) => new ChatScreen(),
              "/listcase": (BuildContext context) => new CaseROList(),
              "/splash": (BuildContext context) => new SplashScreen(),
              "/settings": (BuildContext context) => new Settings(),
              "/ChatPage": (BuildContext context) => new AllChatsPage(),
              "/rating": (BuildContext context) => new Rating2(),
              //"/chat": (BuildContext context) => new ChatScr(),
            }
        )
    );
  }
}


