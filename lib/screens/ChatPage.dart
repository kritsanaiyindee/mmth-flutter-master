import 'package:flutter/material.dart';
import 'package:mmth_flutter/constants/Theme.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:mmth_flutter/screens/User.dart';
import 'package:mmth_flutter/screens/Message.dart';
import 'package:mmth_flutter/screens/ChatModel.dart';
class ChatPage extends StatefulWidget {
  final User friend;
  ChatPage(this.friend);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  Widget buildSingleMessage(Message message) {
    return Container(
      alignment: message.senderID == widget.friend.chatID
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text),
    );
  }

  Widget buildChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {

        List<Message> messages =
        model.getMessagesForChatID(widget.friend.chatID);

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
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
  void updateButtonState(ChatModel cm){
    // if text field has a value and button is inactive
    cm.typingMessage(widget.friend.chatID);
  }
  Widget buildChatArea() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {

        return Container(
          child: Column(
            children: <Widget>[
              ListView.builder(
                itemCount: model.messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  onChanged: (value) => updateButtonState(model),
                  controller: textEditingController,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                onPressed: () {
                  model.sendMessage(
                      textEditingController.text, widget.friend.chatID);
                      textEditingController.text = '';
                },
                elevation: 0,
                child: Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget buildChatAreaDesign() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return Container(

          child:
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      //controller: textEditingController,
                      onChanged: (value) => updateButtonState(model),
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){  model.sendMessage(
                        textEditingController.text, widget.friend.chatID);
                    textEditingController.text = '';},
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.name),
      ),
      body: ListView(
        children: <Widget>[
          buildChatList(),
          //buildChatAreaDesign(),
          buildChatArea(),
         // buildChatArea(),

        ],
      ),
    );
  }
}