import 'package:mmth_flutter/screens/AllChatsPage.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:mmth_flutter/screens/FauxLoginPage.dart';
import 'package:mmth_flutter/screens/chat_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mmth_flutter/screens/login_mitsu.dart';
import 'package:mmth_flutter/screens/splash.dart';
import 'package:mmth_flutter/service/user_list.dart';
import 'package:flutter/material.dart';

// screens
import 'package:mmth_flutter/screens/onboarding.dart';
import 'package:mmth_flutter/screens/pro.dart';
import 'package:mmth_flutter/screens/home.dart';
import 'package:mmth_flutter/screens/home_new.dart';
import 'package:mmth_flutter/screens/profile.dart';
import 'package:mmth_flutter/screens/register.dart';
import 'package:mmth_flutter/screens/articles.dart';
import 'package:mmth_flutter/screens/elements.dart';
import 'package:mmth_flutter/screens/rating.dart';
import 'package:mmth_flutter/screens/list_case.dart';
import 'package:mmth_flutter/form/case_create_form.dart';
import 'package:mmth_flutter/screens/settings.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as statusCodes;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
        debugShowCheckedModeBanner: true,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home": (BuildContext context) => new HomeMitsu(),
          "/createcase": (BuildContext context) => new TextFormFieldDemo(),
          "/profile": (BuildContext context) => new Profile(),
          "/articles": (BuildContext context) => new Articles(),
          "/FauxLoginPage": (BuildContext context) => new FauxLoginPage(),
          "/account": (BuildContext context) => new Register(),
          "/login2": (BuildContext context) => new LoginMitsu2(),
          "/ChatScreen": (BuildContext context) => new ChatScreen(),
          "/caselist": (BuildContext context) => new CaseList(),
          "/splash": (BuildContext context) => new SplashScreen(),
          "/settings": (BuildContext context) => new Settings(),
          "/ChatPage": (BuildContext context) => new AllChatsPage(),
        }
    )
    );
  }
}


