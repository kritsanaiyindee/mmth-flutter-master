import 'dart:convert';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:mmth_flutter/screens/User.dart';
import 'package:mmth_flutter/screens/Message.dart';

class ChatModel extends Model {
  List<User> users = [
    User('IronMan', '111'),
    User('Captain America', '222'),
    User('Antman', '333'),
    User('Hulk', '444'),
    User('Thor', '555'),
  ];

  User currentUser;
  List<User> friendList = List<User>();
  List<Message> messages = List<Message>();
  SocketIO socketIO;


  void init() {
    print('initClicked');
    currentUser = users[0];
    friendList =    users.where((user) => user.chatID != currentUser.chatID).toList();
    //print('http://192.168.97.164:8080');
    socketIO = SocketIOManager().createSocketIO(
        'http://192.168.1.103:8080', '/',socketStatusCallback: _socketStatus);
    //'https://mmth-chat-nodejs.herokuapp.com', '/',socketStatusCallback: _socketStatus);
    socketIO.init();
    print('Init');
    socketIO.subscribe("typing", _onReceiveChatMessage);



    socketIO.sendMessage(
      'change_username',
      json.encode({
        'nickName': users[0].name
      }),
    );



    socketIO.subscribe('new_message', (jsonData) {
      print('xxxx');
      print(jsonData);
      Map<String, dynamic> data = json.decode(jsonData);
      DateTime now = DateTime.now();
      messages.add(Message(data['message'], data['username'], data['color'],now));
      notifyListeners();
    });

    socketIO.connect();
    print('connect');
  }
  _socketStatus(dynamic data) {
    print("Socket statusxxxxxxxxxxxxxxxxxxxxxxx: " + data);
  }
  void socketInfo(dynamic message) {
    print("Socket Info: " + message);
  }

  void _onReceiveChatMessage(dynamic message) {
    print( message+"   Typing " );
  }
  _onSocketInfo(dynamic data) {
    print("Socket info: " + data);
  }

  void typingMessage(String name) {
    print('');
    //messages.add(Message(text, currentUser.chatID, receiverChatID));
    socketIO.sendMessage(
      'typing',
      json.encode({
        'username': name,
      }),
    );
    notifyListeners();
  }

  void sendMessage(String text, String receiverChatID) {
    DateTime now = DateTime.now();
    messages.add(Message(text, currentUser.chatID, receiverChatID,now));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'message': text,
        'username': currentUser.chatID,
        'color': text,
      }),
    );
    notifyListeners();
  }
  void joinChatRoom(String nickName) {

    socketIO.sendMessage(
      'change_username',
      json.encode({
        'nickName': nickName,
      }),
    );
    notifyListeners();
  }
  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID )
        .toList();
  }
}