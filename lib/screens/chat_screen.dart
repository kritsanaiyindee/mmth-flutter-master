import 'dart:io';

import 'package:mmth_flutter/screens/Message.dart';
import 'package:mmth_flutter/screens/full_screen_image.dart';
import 'package:mmth_flutter/model/message.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mmth_flutter/screens/full_screen_image.dart';
import 'package:mmth_flutter/constants/Theme.dart';

//widgets
import 'package:mmth_flutter/widgets/navbar.dart';
import 'package:mmth_flutter/widgets/drawer.dart';
class ChatScreen extends StatefulWidget {
  String name;
  String photoUrl;
  String receiverUid;
  ChatScreen({this.name, this.photoUrl, this.receiverUid});

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatMessage _message;
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  //DocumentSnapshot documentSnapshot;
  String _senderuid="test";
  var listItem;
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  File imageFile;
  TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();

  }

  @override
  void dispose() {
    super.dispose();

  }

  void addMessageToDb(ChatMessage message) async {
    print("Message : ${message.message}");
    map = message.toMap();

    print("Map : ${map}");


    _messageController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Profile",
          transparent: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Profile"),
        body: Form(
          key: _formKey,
          child: _senderuid == null
              ? Container(
            child: CircularProgressIndicator(),
          )
              : Column(
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
          ),
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
    setState(() {
      imageFile = selectedImage;
    });
    var url ;
    uploadImageToDb(url);
    return url;
  }

  void uploadImageToDb(String downloadUrl) {
    _message = ChatMessage.withoutMessage(
        receiverUid: widget.receiverUid,
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
        receiverUid: widget.receiverUid,
        senderUid: _senderuid,
        message: text,
        //timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "receiverUid: ${widget.receiverUid} , senderUid : ${_senderuid} , message: ${text}");
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(_message);
  }



  Widget ChatMessagesListWidget() {
    print("SENDERUID : $_senderuid");
    return ScopedModelDescendant<ChatModel>(
        builder: (context, child, model)
        {
    return Flexible(
      child: StreamBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              //child: CircularProgressIndicator(),
            );
          } else {
            listItem = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  chatMessageItem(model.messages[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
        },
    );
  }

  Widget chatMessageItem(Message m) {
    return buildChatLayout(m);
  }

  Widget buildChatLayout(Message m) {
    return ScopedModelDescendant<ChatModel>(
        builder: (context, child, model)
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: model.users[0].chatID == _senderuid ?
              MainAxisAlignment.end : MainAxisAlignment.start,
              children: <Widget>[
                model.users[0].chatID == _senderuid
                    ? CircleAvatar(
                  backgroundImage: senderPhotoUrl == null
                      ? AssetImage('assets/blankimage.png')
                      : NetworkImage(senderPhotoUrl),
                  radius: 20.0,
                )
                    : CircleAvatar(
                  backgroundImage: receiverPhotoUrl == null
                      ? AssetImage('assets/blankimage.png')
                      : NetworkImage(receiverPhotoUrl),
                  radius: 20.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    model.users[0].chatID == _senderuid
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
                    model.messages[0].text == 'text'
                        ? new Text(
                      model.messages[0].text,
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    )
                        : InkWell(
                      onTap: (() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenImage(
                                      photoUrl: model.messages[0].text,)));
                      }),
                      child: Hero(
                        tag: model.messages[0].text,
                        child: FadeInImage(
                          image: NetworkImage(model.messages[0].text),
                          placeholder: AssetImage('assets/blankimage.png'),
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    },
    );
  }
}