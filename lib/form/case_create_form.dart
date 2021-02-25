// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
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
class TextFieldDemo extends StatelessWidget {
  const TextFieldDemo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Profile",
        transparent: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Profile"),
      body: TextFormFieldDemo(),
    );
  }
}

class TextFormFieldDemo extends StatefulWidget {
  const TextFormFieldDemo({Key key}) : super(key: key);

  @override
  TextFormFieldDemoState createState() => TextFormFieldDemoState();
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

class TextFormFieldDemoState extends State<TextFormFieldDemo> {
  PersonData person = PersonData();

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
    const sizedBoxSpace = SizedBox(height: 24);

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
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(
                    placeholder: "หัวข้อ",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                //sizedBoxSpace,
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Input(
                    placeholder: "Category",
                    prefixIcon: Icon(Icons.subject),
                  ),
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.phone),
                    hintText: "demoTextFieldWhereCanWeReachYou",
                    labelText: "demoTextFieldPhoneNumber",
                    prefixText: '+1 ',
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    person.phoneNumber = value;
                  },
                  maxLength: 14,
                  maxLengthEnforced: false,
                  validator: _validatePhoneNumber,
                  // TextInputFormatters are applied in sequence.
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    _phoneNumberFormatter,
                  ],
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.email),
                    hintText: "demoTextFieldYourEmailAddress",
                    labelText:
                    "demoTextFieldEmail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    person.email = value;
                  },
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "demoTextFieldTellUsAboutYourself",
                    helperText: "demoTextFieldKeepItShort",
                    labelText:"demoTextFieldLifeStory",
                  ),
                  maxLines: 3,
                ),
                sizedBoxSpace,
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText:"demoTextFieldSalary",
                    suffixText:"demoTextFieldUSD",
                  ),
                  maxLines: 1,
                ),
                sizedBoxSpace,
                PasswordField(
                  fieldKey: _passwordFieldKey,
                  helperText:
                  "demoTextFieldNoMoreThan",
                  labelText:"demoTextFieldPassword",
                  onFieldSubmitted: (value) {
                    setState(() {
                      person.password = value;
                    });
                  },
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: "demoTextFieldRetypePassword",
                  ),
                  maxLength: 8,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                sizedBoxSpace,
                /*Center(
                  child: ElevatedButton(
                    child: Text(
                        "demoTextFieldSubmit"),
                    onPressed: _handleSubmitted,
                  ),
                ),*/
                sizedBoxSpace,
                Text(
                  "demoTextFieldRequiredField",
                  style: Theme.of(context).textTheme.caption,
                ),
                sizedBoxSpace,
              ],
            ),
          ),
        ),
      ),

        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.add, title: "Home"),
            TabData(iconData: Icons.search, title: "Search"),
            TabData(iconData: Icons.save, title: "Basket")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedIndex = position;
            });
          },
          barBackgroundColor: ArgonColors.black,
          activeIconColor: ArgonColors.red_mitsu ,
          circleColor: Colors.white,
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

