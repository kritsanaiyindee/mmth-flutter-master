import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mmth_flutter/constants/Theme.dart';
class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.black;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _username = "";
  String _versionName = 'V0.1.1';
  final splashDelay = 8;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    //_loadWidget();

  }
  _loadUserInfo() async {
    //SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _duration = Duration(seconds: splashDelay);

    _username = (prefs.getString('username') ?? "");
    _loadWidget();
  }
  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
   // _loadUserInfo();
    if (_username == "") {
      Navigator.pushReplacementNamed(context, '/login2');
      print("Please sign in");
    } else {
      Navigator.pushReplacementNamed(context, '/home');
      print("Already Logged in");
    }
    //Navigator.pushReplacementNamed(context, '/login2');
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AfterSplash()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        splashColor: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/img/mitsu_logo.png',
                            height: 300,
                            width: 300,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Container(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: <Widget>[
                            Spacer(),
                            Text(_versionName ,style: TextStyle(color:Colors.white,fontSize: 12 ,fontWeight: FontWeight.w700),),
                            Spacer(
                              flex: 4,
                            ),
                            Text('MMTh Tech Line', style: TextStyle(color:Colors.white,fontSize: 12 ,fontWeight: FontWeight.w700),),
                            Spacer(),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}