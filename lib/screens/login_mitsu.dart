import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';

/**
 * Author: Sudip Thapa
 * profile: https://github.com/sudeepthapa
 */
import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:mmth_flutter/screens/dashboard1.dart';
import 'package:mmth_flutter/screens/passcode.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';

class LoginMitsu2 extends StatefulWidget {
  //static final String path = "lib/screens/login_mitsu.dart";
  @override
  _LoginMitsu2State createState() => _LoginMitsu2State();
}

Future<bool> loginAction() async {
  //replace the below line of code with your login request

  await new Future.delayed(const Duration(seconds: 2));
  return true;
}

class _LoginMitsu2State extends State<LoginMitsu2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  bool isRegistered = false;
  bool _autovalidate = false;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _read();
      print('xxxxxxxxxxxxxxxxxxxxxx');
      print(isRegistered);
      print(_email);
      if (isRegistered && _email != "") {
       // await _lockScreen();
      }
      print('xxxxxxxxxxxxxxxxxxxxxx');
    });
  }

  Future<void> _read() async {
    //SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('username') ?? "");
    isRegistered = (prefs.getBool('isRegistered') ?? false);
    _password= (prefs.getString('password') ?? "");
    setState(() {
      txtEmail.text = _email;
      txtPassword.text=_password;
    });

    //_loadWidget();
  }

  Future<void> _lockScreen() async {
    //SharedPreferences.setMockInitialValues({});
    _showLockScreen(
      context,
      opaque: false,
      cancelButton: Text(
        'Cancel',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
    );
  }

  void _handleSubmitted() async {
    print("_handleSubmitted  Click");
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      print("Error");
      Navigator.pushReplacementNamed(context, '/dashboard2');
      //showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      if (_password == "password") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print("username===" + _email);
        prefs.setString("username", _email);
        prefs.setString("password", _password);

        prefs.setBool("isRegistered", true);
        //prefs.setBool(key, value)
        //Navigator.pushReplacementNamed(context, '/home');

        Navigator.pushReplacementNamed(context, '/dashboard2');
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isRegistered", false);
        //showInSnackBar('Incorrect credentials');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    //print('isRegistered');
    //print(isRegistered);
    //print(_email);
    //if (!isRegistered && _email == "") {
     //print('xxxx1');
      return Scaffold(
          key: _scaffoldKey,
          backgroundColor: ArgonColors.nearWhite,
          body: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                  color: ArgonColors.white,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            /*
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [ArgonColors.red_mitsu, Color(0x22fe494d)])),

                ),
              ),

              ClipPath(
                //clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [ArgonColors.red_mitsu, ArgonColors.black])),
                ),
              ),*/
                            ClipPath(
                              //clipper: WaveClipper1(),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 0,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      "assets/img/mitsu_logo_login.png",
                                      width: 200,
                                    ),
                                    SizedBox(
                                      //width: 250.0,
                                      child: ColorizeAnimatedTextKit(
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                        text: [
                                          "Drive your Ambition",
                                        ],
                                        textStyle: TextStyle(
                                          fontSize: 24.0,
                                          fontFamily: "Horizon",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        colors: [
                                          ArgonColors.white,
                                          ArgonColors.nearWhite,
                                          ArgonColors.red_mitsu,
                                          ArgonColors.red_mitsu2,
                                        ],
                                        textAlign: TextAlign.start,
                                        isRepeatingAnimation: true,
                                        totalRepeatCount: 50,
                                      ),
                                    ),
                                    /*Text(
                        "Taste Me",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 30),
                      ),*/
                                  ],
                                ),
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.black, Colors.black])),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              controller: txtEmail,
                              key: Key("_email"),
                              onChanged: (String value) {},
                              cursorColor: Colors.deepOrange,
                              onSaved: (String value) {
                                _email = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Material(
                                    elevation: 0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Icon(
                                      Icons.email,
                                      color: ArgonColors.red_mitsu,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              controller: txtPassword,
                              key: Key("_password"),
                              onChanged: (String value) {},
                              cursorColor: Colors.deepOrange,
                              onSaved: (String value) {
                                _password = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Material(
                                    elevation: 0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.red,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: ArgonColors.red_mitsu),
                              child: FlatButton(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                onPressed: _handleSubmitted,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "FORGET PASSWORD ?",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an Account ? ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            //Text("Sign Up ", style: TextStyle(color:Colors.red, fontWeight: FontWeight.w500,fontSize: 12, decoration: TextDecoration.underline )),
                          ],
                        )
                      ],
                    ),
                  ))));
    //}
    /*else if (!isRegistered && _email != "") {
      print('xxxx2');
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ArgonColors.nearWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated'),
              Container(),
              //_defaultLockScreenButton(context),
              //_customColorsLockScreenButton(context)
            ],
          ),
        ),
      );
    }
    else {
      print('xxxx3');
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ArgonColors.nearWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated'),
              Container(),
              //_defaultLockScreenButton(context),
              //_customColorsLockScreenButton(context)
            ],
          ),
        ),
      );
    }

     */
  }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
        color: ArgonColors.red_mitsu2,
        child: Text('Open Default Lock Screen'),
        onPressed: () {
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'Cancel',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Cancel',
            ),
          );
        },
      );

  _showLockScreen(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig,
      KeyboardUIConfig keyboardUIConfig,
      Widget cancelButton,
      List<String> digits}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
          PasscodeScreen(
            title: Text(
              'Enter App Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            cancelCallback: _onPasscodeCancelled,
            digits: digits,
            passwordDigits: 6,
            bottomWidget: _buildPasscodeRestoreButton(),
          )),
        );
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    print('enteredPasscode');
    print(enteredPasscode);
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
        this._verificationNotifier.add(isValid);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashboardOnePage()));
      });
      //Navigator.pushReplacementNamed(context, '/dashboard2');
      //Navigator.
     // Navigator.pushReplacementNamed(context, '/dashboard2');


    }
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _buildPasscodeRestoreButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: FlatButton(
            child: Text(
              "Reset passcode",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            splashColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.white.withOpacity(0.2),
            onPressed: _resetAppPassword,
          ),
        ),
      );

  _resetAppPassword()  {
    Navigator.maybePop(context).then((result) {
      print('result');
      print(result);
      if (!result) {
        return;
      }
      _showRestoreDialog(()  async{
        Navigator.maybePop(context);
        //TODO: Clear your stored passcode here
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print("username===" + _email);
        prefs.setString("username", "");
        prefs.setBool("isRegistered", false);
        Navigator.pushReplacementNamed(context, '/login2');
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Reset passcode",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(
                "Cancel",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            FlatButton(
              child: Text(
                "I understand",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: onAccepted,
            ),
          ],
        );
      },
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
