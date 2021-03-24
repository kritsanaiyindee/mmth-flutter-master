import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:mmth_flutter/screens/Message.dart';
import 'package:mmth_flutter/screens/full_screen_image.dart';
import 'package:mmth_flutter/model/message.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:mmth_flutter/ui/block_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mmth_flutter/screens/full_screen_image.dart';
import 'package:mmth_flutter/constants/Theme.dart';

//widgets
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
class ChatScreen1 extends StatelessWidget {
  ChatMessage _message;
  // final GlobalKey _scaffoldKey = new GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  var map = Map<String, dynamic>();
  //DocumentSnapshot documentSnapshot;
  String _senderuid="test";
  var listItem;
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  File imageFile;
  TextEditingController _messageController;


  void addMessageToDb(ChatMessage message) async {
    print("Message : ${message.message}");
    map = message.toMap();

    print("Map : ${map}");


    _messageController.text = "";
  }
/*
  @override
  Widget build(BuildContext context) {
    // var data = EasyLocalizationProvider.of(context).data;
    // final lang = AppLocalizations.of(context);

    const sizedBoxSpace = SizedBox(height: 16);
    return  Form(
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
              //ChatInputWidget(),

            ],
          ),
        ),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: _senderuid == null
              ? Container(
            child: CircularProgressIndicator(),
          )
              :BlockWrapper( Column(
            children: <Widget>[
              //buildListLayout(),
              ChatMessagesListWidget(),
              Divider(
                height: 20.0,
                color: Colors.black,
              ),
              ChatInputWidget(),
              SizedBox(
                height: 10.0,
              )
            ],
          )),
        ));
  }
  Widget ChatInputWidget() {
    print("SENDERUID : $_senderuid");
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
                      pickImage();
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
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: "Enter message...",
                        labelText: "Message",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onFieldSubmitted: (value) {
                      _messageController.text = value;
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
                          model.sendMessage( _messageController.text, "xxxx");
                          _messageController.text = '';
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

  Future<String> pickImage() async {
    var selectedImage =
    await ImagePicker.pickImage(source: ImageSource.gallery);
    var url ;
    uploadImageToDb(url);
    return url;
  }

  void uploadImageToDb(String downloadUrl) {
    _message = ChatMessage.withoutMessage(
        receiverUid: "3333",
        senderUid: _senderuid,
        photoUrl: downloadUrl,
        //timestamp: FieldValue.serverTimestamp(),
        type: 'image');
    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['receiverUid'] = _message.receiverUid;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['photoUrl'] = _message.photoUrl;

    print("Map : ${map}");

  }

  void sendMessage() async {
    print("Inside send message");
    var text = _messageController.text;
    print(text);
    _message = ChatMessage(
        receiverUid: "3333",//widget.receiverUid"",
        senderUid: _senderuid,
        message: text,
        //timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "receiverUid:3333 , senderUid : ${_senderuid} , message: ${text}");
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(_message);
  }
  Widget buildSingleMessage(Message message) {
    return Container(
      alignment: message.senderID == "Techline"
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text+'\n'+message.senderID),
    );
  }

  Widget ChatMessagesListWidget() {
    print("SENDERUID : $_senderuid");
    List<Message> messages = List<Message>();
    DateTime now = DateTime.now();
    messages.add(Message("สอบถามการซ่อม", "Techline", "blue",now));
    messages.add(Message("ขอข้อมูลคับ", "Dealer", "red",now));
    messages.add(Message("เครื่องยนต์เสีย", "Techline", "blue",now));
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {

          return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return buildChatLayout(messages[index]);
            },
          ),
        );
      },
    );

  }
  Widget buildChatLayout(Message m) {
    _senderuid="Dealer";
    print(m.senderID);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment:m.senderID == _senderuid ?
                MainAxisAlignment.end : MainAxisAlignment.start,
                children: <Widget>[
                  m.senderID == _senderuid
                      ? CircleAvatar(
                    backgroundImage:
                         AssetImage('assets/img/supportIcon.png'),
                    radius: 20.0,
                  )
                      : CircleAvatar(
                    backgroundImage: AssetImage('assets/img/supportIcon.png'),
                    radius: 20.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      m.senderID == _senderuid
                          ? new Text(
                        senderName == null ? "" : senderName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      )
                          : new Text(
                        receiverName == null ? "" : receiverName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      m.text == 'text'
                          ? new Text(
                        m.text,
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      )
                          : InkWell(
                        onTap: (() {

                        }),
                        child: Text(
                           m.text,

                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        );

  }
  Widget chatMessageItem(Message m) {
    return buildChatLayout(m);
  }

}