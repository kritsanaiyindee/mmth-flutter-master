// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:mmth_flutter/screens/text_field_datepicker.dart';
import 'package:mmth_flutter/widgets/bottomNavigation.dart';

import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';

import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

//widgets
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
import 'package:mmth_flutter/widgets/input.dart';
import 'package:mmth_flutter/widgets/slider-product.dart';

class ROCreate extends StatelessWidget {
  const ROCreate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "RO Create",
        transparent: true,
      ),
      backgroundColor: ArgonColors.white,
      drawer: ArgonDrawer(currentPage: "RO Create"),
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

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
  GlobalKey<FormFieldState<String>>();
  final _UsNumberTextInputFormatter _phoneNumberFormatter =
  _UsNumberTextInputFormatter();

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      showInSnackBar(
        "GalleryLocalizations.of(context).demoTextFieldFormErrors",
      );
    } else {
      form.save();
      showInSnackBar(".demoTextFieldNameHasPhoneNumber(person.name, person.phoneNumber)");
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
  final Map<String, Map<String, dynamic>> articlesCards = {
    "Ice Cream": {
      "title": "Ice cream is made with carrageenan …",
      "image":
      "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
    },
    "Makeup": {
      "title": "Is makeup one of your daily esse …",
      "image":
      "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
    },
    "Coffee": {
      "title": "Coffee is more than just a drink: It’s …",
      "image":
      "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
    },
    "Fashion": {
      "title": "Fashion is a popular style, especially in …",
      "image":
      "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
    },
    "Argon": {
      "title": "Argon is a great free UI packag …",
      "image":
      "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
    },
    "Music": {
      "title": "View article",
      "image":
      "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
      "products": [
        {
          "img":
          "assets/img/supportIcon.png",
          "title": "CASEID-100001",
          "description":
          "You need a creative space ready for your art? We got that covered.",
          "price": "\$125",
        },
        {
          "img":
          "assets/img/supportIcon.png",
          "title": "CASEID-100002",
          "description":
          "Don't forget to visit one of the coolest art galleries in town.",
          "price": "\$200",
        },
        {
          "img":
          "assets/img/supportIcon.png",
          "title": "CASEID-100003",
          "description":
          "Some of the best music video services someone could have for the lowest prices.",
          "price": "\$300",
        },
      ],
      "suggestions": [
        {
          "img":
          "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
          "title": "Music studio for real..."
        },
        {
          "img":
          "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
          "title": "Music equipment to borrow..."
        },
      ]
    }
  };
  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 16);

    return Scaffold(
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

        child: Scrollbar(

          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                sizedBoxSpace,
                //ProductCarousel(imgArray: articlesCards["Music"]["products"]),
                if(_selectedIndex==0)Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Input(
                  labelText: "RO Number",
                  placeholder: "ระบุ RO Number",
                  prefixIcon: Icon(Icons.subject),
                ),
                ),
                //sizedBoxSpace,
                if(_selectedIndex==0)Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MyTextFieldDatePicker(
                labelText: "RO Date",
                prefixIcon: Icon(Icons.date_range),
                suffixIcon: Icon(Icons.arrow_drop_down),
                lastDate: DateTime.now().add(Duration(days: 366)),
                firstDate: DateTime.now(),
                initialDate: DateTime.now().add(Duration(days: 1)),
                onDateChanged: (selectedDate) {
                // Do something with the selected date
                },
                ),
                ),
                if(_selectedIndex==0)Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: DropdownButton<String>(
                value: _chosenValue,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                'PHP',
                ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
                );
                }).toList(),
                hint: Text(
                "เลือกประเภทงาน",
                style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600),
                ),
                onChanged: (String value) {
                setState(() {
                _chosenValue = value;
                });
                },
                ),
                ),
                if(_selectedIndex==0)Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MyTextFieldDatePicker(
                labelText: "วันที่ลูกค้าต้องการ",
                prefixIcon: Icon(Icons.date_range),
                suffixIcon: Icon(Icons.arrow_drop_down),
                lastDate: DateTime.now().add(Duration(days: 366)),
                firstDate: DateTime.now(),
                initialDate: DateTime.now().add(Duration(days: 1)),
                onDateChanged: (selectedDate) {
                // Do something with the selected date
                },
                ),
                ),
                if(_selectedIndex==0)Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: DropdownButton<String>(
                value: _chosenValue,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                'PHP',
                ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
                );
                }).toList(),
                hint: Text(
                "สถานะงาน",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
                ),
                onChanged: (String value) {
                setState(() {
                _chosenValue = value;
                });
                },
                ),
                ),
                if(_selectedIndex==0)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: MyTextFieldDatePicker(
                    labelText: "วันที่เริ่มรับประกัน",
                    prefixIcon: Icon(Icons.date_range),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    lastDate: DateTime.now().add(Duration(days: 366)),
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now().add(Duration(days: 1)),
                    onDateChanged: (selectedDate) {
                      // Do something with the selected date
                    },
                  ),
                ),
                if(_selectedIndex==0)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: MyTextFieldDatePicker(
                    labelText: "วันที่สิ้นสุดการรับประกัน",
                    prefixIcon: Icon(Icons.date_range),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    lastDate: DateTime.now().add(Duration(days: 366)),
                    firstDate: DateTime.now(),
                    initialDate: DateTime.now().add(Duration(days: 1)),
                    onDateChanged: (selectedDate) {
                      // Do something with the selected date
                    },
                  ),
                ),
                if(_selectedIndex==1)Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child:
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
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
    ),
                if(_selectedIndex==1)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child:
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
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
                ),
                if(_selectedIndex==1)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(
                    placeholder: "Message",
                    labelText: "Message",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),

                if(_selectedIndex==3)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(

                    placeholder: "รหัสสั่งซ่อม",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                if(_selectedIndex==3)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(

                    placeholder: "คำสั่งซ่อม",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                if(_selectedIndex==3)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(

                    placeholder: "ประเภทสั่งซ่อม",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                if(_selectedIndex==3)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(

                    placeholder: "โค้ดปฏิบัติงาน",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                if(_selectedIndex==3)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(

                    placeholder: "รายการ",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                if(_selectedIndex==3)Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(

                    placeholder: "ประเภทการจ่าย",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.add, title: "RO"),
            TabData(iconData: Icons.search, title: "Car"),
            TabData(iconData: Icons.accessibility_sharp, title: "Owner"),
            TabData(iconData: Icons.library_add_check, title: "Incident")
          ],
          onTabChangedListener: (position) {
            setState(() {
              print(position);
              _selectedIndex = position;
            });
          },
          barBackgroundColor: ArgonColors.black,
          activeIconColor: ArgonColors.red_mitsu ,
          circleColor: Colors.white,
          textColor: Colors.white,
        )
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

