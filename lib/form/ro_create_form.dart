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
import 'package:mmth_flutter/screens/page1.dart';
import 'package:mmth_flutter/screens/page2.dart';
import 'package:mmth_flutter/screens/page3.dart';
import 'package:mmth_flutter/screens/page4.dart';
import 'package:mmth_flutter/screens/text_field_datepicker.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
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
  final List<Widget> _children = [
    Page1(),
    Page2(),
    ChatScreen1(),
    Page3(),

  ];

  final List<BottomNavigationBarItem> _childrenBottom = [
    new BottomNavigationBarItem(
      icon: Icon(Icons.add,color: ArgonColors.red_mitsu2,),
      title: Text('RO Detail'),
    ),
  /*  new BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.pen,color: ArgonColors.red_mitsu2,),
      title: Text('Case'),
    ),
    new BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.star,color: ArgonColors.red_mitsu2,),
        title: Text('Rating')
    ),
    new BottomNavigationBarItem(
        icon: Icon(FontAwesomeIcons.rocketchat,color: ArgonColors.red_mitsu2,),
        title: Text('Chat')
    )*/
  ];



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
  var returndata = 0; //variable for return data

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
  int _selectedIndex = 1;
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
    //ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
    //print('_selectedIndex==%_selectedIndex');
    //print(_selectedIndex);
    setState(() {
      //print('setState');
     // _selectedIndex = 0;
      //print(_selectedIndex);
    });
    return


      Scaffold(
          /*extendBodyBehindAppBar: true,
          appBar: Navbar(
            title: "Create Case",
            transparent: false,

          ),
          backgroundColor: ArgonColors.bgColorScreen,
          drawer: ArgonDrawer(currentPage: "Create Case"),*/
          body: _children[_selectedIndex],

          bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped, // new
            //initialSelection: 0,
            backgroundColor: ArgonColors.black_mitsu,
            unselectedItemColor: Colors.green,
            selectedItemColor: Colors.black,
            currentIndex: _selectedIndex, //
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.add,color: ArgonColors.red_mitsu2,),
                title: Text('RO Detail'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.pen,color: ArgonColors.red_mitsu2,),
                title: Text('Case'),
              ),
              new BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.rocketchat,color: ArgonColors.red_mitsu2,),
                  title: Text('Chat')
              ),
              new BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.star,color: ArgonColors.red_mitsu2,),
                  title: Text('Rating')
              ),

            ],

          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Visibility(
            visible: (_selectedIndex==1||_selectedIndex==3), // set it to false
            child:  FloatingActionButton(
              splashColor: ArgonColors.black_mitsu,
              foregroundColor: ArgonColors.red_mitsu2,
              focusColor: ArgonColors.red_mitsu2,
              backgroundColor: ArgonColors.red_mitsu2,
                onPressed:(){
                //_incrementTab(1);
                },
                tooltip: 'Increment',
    child:CircleAvatar(
    //color: Colors.black,
    backgroundColor: Colors.red,
    child: new IconButton(
    icon: new Icon(Icons.save,color: Colors.white,),
    onPressed:() {
    //Navigator.pushReplacementNamed(context, '/createcase');
    }),
    )
            ), // visible if showShould is true

          )

        /* barBackgroundColor: ArgonColors.black,
            activeIconColor: ArgonColors.red_mitsu,
            circleColor: Colors.white,
            textColor: Colors.white,
          )*/
      );

  }
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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



