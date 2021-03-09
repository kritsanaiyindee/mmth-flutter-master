// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:mmth_flutter/screens/ChatPage.dart';
import 'package:mmth_flutter/screens/Message.dart';
import 'package:mmth_flutter/screens/User.dart';
import 'package:mmth_flutter/screens/rating.dart';
import 'package:mmth_flutter/screens/text_field_datepicker.dart';
import 'package:mmth_flutter/widgets/bottomNavigation.dart';

import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

//widgets
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:mmth_flutter/widgets/input.dart';
import 'package:mmth_flutter/widgets/slider-product.dart';
import 'package:scoped_model/scoped_model.dart';

class ROCreate extends StatelessWidget {
  const ROCreate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "CASE Create",
        transparent: true,
      ),
      backgroundColor: ArgonColors.white,
      drawer: ArgonDrawer(currentPage: "CASE Create"),
      body: ROCreateForm(),
    );
  }
}

class ROCreateForm extends StatefulWidget {
  const ROCreateForm({Key key}) : super(key: key);

  @override
  ROCreateFormState createState() => ROCreateFormState();
}

class PersonData {
  String name = 'xxx';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            semanticLabel: _obscureText
                ? "demoTextFieldShowPasswordLabel"

                :"demoTextFieldHidePasswordLabel"
            ,
          ),
        ),
      ),
    );
  }
}

class ROCreateFormState extends State<ROCreateForm> {
  PersonData person = PersonData();
  String _chosenValue;
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  @override
  void initState() {
    super.initState();

  }

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
  GlobalKey<FormFieldState<String>>();
  final _UsNumberTextInputFormatter _phoneNumberFormatter =
  _UsNumberTextInputFormatter();


  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    firstName: "Fayeed",
    lastName: "Pawaskar",
    uid: "12345678",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
  );

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;
  //User friend = model.friendList[index];


  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {

      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      showInSnackBar("GalleryLocalizations.of(context).demoTextFieldFormErrors",
      );
    } else {
      form.save();
     // showInSnackBar(".demoTextFieldNameHasPhoneNumber(person.name, person.phoneNumber)");
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "demoTextFieldNameRequired";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "demoTextFieldOnlyAlphabeticalChars";
    }
    return null;
  }

  String _validatePhoneNumber(String value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) {
      return "demoTextFieldEnterUSPhoneNumber";
    }
    return null;
  }

  String _validatePassword(String value) {
    final passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty) {
      return "demoTextFieldEnterPassword";
    }
    if (passwordField.value != value) {
      return "demoTextFieldPasswordsDoNotMatch";
    }
    return null;
  }
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index){
      case 0:
        Navigator.pushNamed(context, "/home");
        break;
    //case 1:
    //  Navigator.pushNamed(context, "/account");
    //  break;
    }
  }
  GlobalKey floatingKey = LabeledGlobalKey("Floating");
  bool isFloatingOpen = false;
  OverlayEntry floating;

  OverlayEntry createFloating() {
    RenderBox renderBox = floatingKey.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) {
          return Positioned(
              left: offset.dx,
              width: renderBox.size.width,
              top: offset.dy - 50,
              child: Material(
                  elevation: 20,
                  child: Container(
                      height: 50,
                      color: Colors.blue,
                      child: Text("I'm floating overlay")
                  )
              )
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 16);
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
    return


      Scaffold(
          extendBodyBehindAppBar: true,
          appBar: Navbar(
            title: "Create Case",
            transparent: false,

          ),
          backgroundColor: ArgonColors.bgColorScreen,
          drawer: ArgonDrawer(currentPage: "Create Case"),
          body: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,

            child: //if(_selectedIndex == 0||if(_selectedIndex == 1):
              Scrollbar(
              child: SingleChildScrollView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    sizedBoxSpace,
                    //ProductCarousel(imgArray: articlesCards["Music"]["products"]),
                    if(_selectedIndex == 0)Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child:
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "RO Number",
                          prefixIcon: Icon(FontAwesomeIcons.searchPlus),

                        ),
                        maxLines: 1,

                      ),
                      /*Input(
                  labelText: "RO Number",
                  placeholder: "ระบุ RO Number",
                  prefixIcon: Icon(Icons.subject),
                ),*/
                    ),
                    sizedBoxSpace,
                    if(_selectedIndex == 0)
                      Text(
                        "รายละเอียด RO",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    if(_selectedIndex == 0)
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[
                              Column(


                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("RO Date",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("13/03/2021",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("ประเภทงาน",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("งาน 1",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("วันที่ลูกค้าต้องการ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("13/03/2021",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("สถานะงาน",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("Active",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("วันรับประกัน",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("13/03/2021",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          sizedBoxSpace,
                                          Column(
                                            children: [
                                              Text("วันสิ้นสุด",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("Active",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                    if(_selectedIndex == 0)
                      Text(
                        "รายละเอียดรถ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    if(_selectedIndex == 0)
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[


                              Column(


                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("เลขตัวถัง",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("MX1234",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("เลขเครื่องยนต์",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("MX1234567890",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("รุ่นต้นแบบ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("Y",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("เลขทะเบียน",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("กพ 1094  ชลบุรี",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("รหัสรถ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("MX1234567890",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    if(_selectedIndex == 0)
                      Text(
                        "ข้อมูลผู้ใช้งาน",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    if(_selectedIndex == 0)
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text("เลขบัตรประชาชน",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text("3200100640666",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                          ]), Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("ชื่อลูกค้า",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("กฤษนัย ยินดีสุข",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                          Column(
                                            children: [
                                              Text("ประเภทลูกค้า",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("บุคคล",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("ที่อยู่",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text(
                                                  "63 หมู่ 8 ตำบลนาป่า อ เมือง จ ชลบุรี",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("รหัสไปรษณีย์",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("20000",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("จังหวัด",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("ชลบุรี",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("เบอร์โทรศัพท์",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("0618515533",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    if(_selectedIndex == 0)
                      Text(
                        "รายละเอียดการสั่งซ่อม",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    if(_selectedIndex == 0)
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(25),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.grey,
                                    tiles: [
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text("รหัสสั่งซ่อม",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text("FX11111",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ), Column(
                                              children: [
                                                Text("คำสั่งซ่อม",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Text("xxxxx",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                          ]), Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [


                                          Column(
                                            children: [
                                              Text("ประเภทสั่งซ่อม",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("ด่วน",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ), Column(
                                            children: [
                                              Text("โค้ดปฏิบัติงาน",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("ปปปปปปป",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [

                                          Column(
                                            children: [
                                              Text("รายการ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("20000",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("ประเภทการจ่าย",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              Text("ปปปปปป",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 12.0))
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    if(_selectedIndex == 1)
                      Text(
                        "สร้าง Case",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    if(_selectedIndex == 1)
                      sizedBoxSpace,
                    if(_selectedIndex == 1) TextFormField(
                      initialValue: "Tech-Line",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Channel",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.pen,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    if(_selectedIndex == 1)sizedBoxSpace,
                    if(_selectedIndex == 1)TextFormField(
                      initialValue: "Mitsubishi Vipawadee",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Dealer",
                        suffixIcon: Icon(FontAwesomeIcons.searchPlus),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    if(_selectedIndex == 1)sizedBoxSpace,
                    if(_selectedIndex == 1)TextFormField(
                      initialValue: "ปัญหาท่อไอเสีย",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Title",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    if(_selectedIndex == 1)sizedBoxSpace,
                    if(_selectedIndex == 1)TextFormField(
                      initialValue: "Inquiry",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "ประเภท",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    if(_selectedIndex == 1)sizedBoxSpace,
                    if(_selectedIndex == 1)TextFormField(
                      initialValue: "Tech-Line",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "กลุ่ม",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),
                    if(_selectedIndex == 1)sizedBoxSpace,
                    if(_selectedIndex == 1)TextFormField(
                      initialValue: "",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "หัวข้อ",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),

                    if(_selectedIndex == 1)sizedBoxSpace,
                    if(_selectedIndex == 1)TextFormField(
                      initialValue: "Kritsanai",
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Owner",
                        suffixIcon: Icon(FontAwesomeIcons.pen),
                        //suffixIcon: FontAwesomeIcons.search,
                        //suffixText:"demoTextFieldUSD",
                      ),
                      maxLines: 1,
                    ),

                    if(_selectedIndex == 1) sizedBoxSpace,
                    //if(_selectedIndex == 2)buildChatList(),
                    //if(_selectedIndex == 2)buildChatArea(),
                    if(_selectedIndex == 1) Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: ArgonColors.red_mitsu),
                      child: FlatButton(
                        child: Text(
                          "สร้าง",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        onPressed: _handleSubmitted,

                      ),
                    ),
                    //if(_selectedIndex == 3) ChatScreen(),
                    //if(_selectedIndex == 3)ChatScr(),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(iconData: Icons.add, title: "RO Detail"),
              TabData(iconData: FontAwesomeIcons.pen, title: "Case"),
              TabData(iconData: FontAwesomeIcons.star, title: "Rating"),
              TabData(iconData: FontAwesomeIcons.rocketchat, title: "Chat")
            ],
            onTabChangedListener: (position) {
              setState(() {
                print(position);
                _selectedIndex = position;
              });
              if(_selectedIndex==2){
                Navigator.pushNamed(context, 'page2');
              //  Navigator.pushReplacementNamed(context, '/rating');
                //_navigateAndDisplayRating(context);
              }else if(_selectedIndex==3){
               // Navigator.pushReplacementNamed(context, '/chat');
                //_navigateAndDisplaySelection(context);
                Widget page = Page2();
                Navigator.pushNamed(context, 'page2');
              }
            },
            barBackgroundColor: ArgonColors.black,
            activeIconColor: ArgonColors.red_mitsu,
            circleColor: Colors.white,
            textColor: Colors.white,
          )
      );

  }


  Widget buildSingleMessage(Message message) {
    return Container(
      alignment: message.senderID == ""
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text),
    );
  }

  Widget buildChatList() {
    print('buildChatList');
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {

        List<Message> messages =
        model.getMessagesForChatID("");

        return Container(
          //color:Colors.blueAccent,
          height: MediaQuery.of(context).size.height * 0.60,
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSingleMessage(messages[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildChatArea() {
    print('buildChatArea');
    return ScopedModelDescendant<ChatModel>(

      builder: (context, child, model) {
        return Container(
          //color:Colors.red,

          child: Column(
            children: <Widget>[
              ListView.builder(
                itemCount: model.messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 0),
                    child: Align(
                      alignment: (model.messages[index].senderID != model.currentUser.chatID?Alignment.topLeft:Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (model.messages[index].senderID  != model.currentUser.chatID?Colors.grey.shade200:Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(model.messages[index].text+"\n"+model.messages[index].dt.toString().substring(0,17), style: TextStyle(fontSize: 12,color: ArgonColors.red_mitsu),),

                      ),
                    ),
                  );
                },
              ),
       // Expanded(
        Align(
        alignment: FractionalOffset.bottomCenter,
        child:
              ChatInputWidget(),
        )
       // )
            ],
          ),
        );
      },
    );
  }
  Widget ChatInputWidget() {
   // print("SENDERUID : $_senderuid");
    return ScopedModelDescendant<ChatModel>(
        builder: (context, child, model)
        {
          return Container(
            height: 55.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    onPressed: () {
                     // pickImage();
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    validator: (String input) {
                      if (input.isEmpty) {
                        return "Please enter message";
                      }
                    },
                    //controller: _messageController,
                    decoration: InputDecoration(
                        hintText: "Enter message...",
                        labelText: "Message",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onFieldSubmitted: (value) {
                    //  _messageController.text = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      splashColor: Colors.white,
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //model.sendMessage( _messageController.text, "xxxx");
                        //  _messageController.text = '';
                        }
                      }

                  ),
                )
              ],
            ),
          );
        }
    );
  }
}

/// Format incoming numeric text to fit the format of (###) ###-#### ##
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page1')),
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.pushNamed(context, 'page2'),
          child: Text('Go to Page2'),
        ),
      ),
    );
  }
}
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Page2')));
}



